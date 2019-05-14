class Package < ApplicationRecord
  BASE_URI = 'https://cran.r-project.org/src/contrib/'.freeze
  REPO_URI = URI.join(BASE_URI, 'PACKAGES')
  FILE_EXTENSION = 'tar.gz'.freeze

  validates :name, :version, presence: true

  def self.repo_uri
    REPO_URI
  end

  def has_required_details?
    return true if title.present?

    false
  end

  def uri
    URI.join(BASE_URI, file_name)
  end

  private

  def file_name
    "#{name}_#{version}.#{file_extension}"
  end

  def file_extension
    FILE_EXTENSION
  end
end
