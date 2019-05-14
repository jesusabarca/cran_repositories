class PackagesController < ApplicationController
  # GET /packages
  def index
    @packages = Package.all
  end
end
