require 'net/http'
require 'dcf'
require 'rubygems/package'

class PackageRetrieverWorker
  include Sidekiq::Worker

  # TODO: refactor into a service object
  def perform(package_id)
    package = Package.find(package_id)
    return if package.has_required_details?

    response = Net::HTTP.get_response(package.uri)
    raise response.message unless response.code == '200'

    ungziped = ungzip(response.body)
    files = untar(ungziped)
    package_description = extract_description(files)

    package.update_attributes(
      published_at: package_description['Date/Publication'],
      title: package_description['Title'],
      description: package_description['Description'],
      authors: package_description['Author'],
      maintainers: package_description['Maintainer']
    )
  end

  private

  def untar(tar_file)
    Gem::Package::TarReader.new(tar_file)
  end

  def ungzip(io)
    Zlib::GzipReader.new(StringIO.new(io))
  end

  def extract_description(files)
    files.rewind
    files.each do |entry|
      next unless entry.full_name.include? 'DESCRIPTION'

      break Dcf.parse(entry.read)&.first
    end
  end
end
