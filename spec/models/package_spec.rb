require 'rails_helper'

RSpec.describe Package, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:version) }

  describe '.repo_uri' do
    let(:expected_uri) {
      'https://cran.r-project.org/src/contrib/PACKAGES'
    }

    it { expect(Package.repo_uri.to_s).to eq(expected_uri) }
  end

  describe '#uri' do
    let(:expected_uri) {
      'https://cran.r-project.org/src/contrib/FirstPackage_1.0.2.tar.gz'
    }

    subject do
      Package.new(
        name: 'FirstPackage',
        version: '1.0.2'
      )
    end

    it { expect(subject.uri.to_s).to eq(expected_uri) }
  end

  describe '#has_required_details?' do
    context 'with a title' do
      subject { Package.new title: 'Random title' }

      it { expect(subject.has_required_details?).to be true }
    end

    context 'without a title' do
      subject { Package.new title: nil }

      it { expect(subject.has_required_details?).to be false }
    end
  end
end
