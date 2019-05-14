require 'rails_helper'

RSpec.describe 'Packages', type: :request do
  describe 'GET /packages' do
    subject { response }

    it 'works! (now write some real specs)' do
      get packages_path
      is_expected.to be_successful
    end
  end
end
