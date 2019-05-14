require 'rails_helper'

RSpec.describe PackagesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/packages').to route_to('packages#index')
    end
  end
end
