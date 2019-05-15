require 'net/http'
require 'dcf'

class RepositoryReaderWorker
  NO_OF_PACKAGES = 50

  include Sidekiq::Worker

  # TODO: refactor into a service object
  def perform
    response = Net::HTTP.get_response(Package.repo_uri)
    raise response.message unless response.code == '200'

    packages = response.body.lines('', chomp: true).first(NO_OF_PACKAGES)
    packages.each do |package|
      package_info = Dcf.parse(package)&.first
      next unless package_info.present?

      persisted_package = Package.find_or_create_by(
        name: package_info['Package'],
        version: package_info['Version']
      )
      break if persisted_package.has_required_details?

      PackageRetrieverWorker.perform_async(persisted_package.id)
    end
  end
end
