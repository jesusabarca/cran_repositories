require 'rails_helper'

RSpec.describe 'packages/index', type: :view do
  before(:each) do
    assign(:packages, [
      Package.create!(
        name: 'First Package',
        version: '1.1.0',
        title: 'Title 1',
        description: 'Awesome package'
      ),
      Package.create!(
        name: 'Second Package',
        version: '1.0.1',
        title: 'Title 2',
        description: 'Great package'
      )
    ])
  end

  it 'renders a list of packages' do
    render
    assert_select 'tr>td', text: 'First Package'.to_s, count: 1
    assert_select 'tr>td', text: 'Second Package'.to_s, count: 1
    assert_select 'tr>td', text: '1.1.0'.to_s, count: 1
    assert_select 'tr>td', text: '1.0.1'.to_s, count: 1
    assert_select 'tr>td', text: 'Title 1'.to_s, count: 1
    assert_select 'tr>td', text: 'Title 2'.to_s, count: 1
    assert_select 'tr>td', text: 'Great package'.to_s, count: 1
    assert_select 'tr>td', text: 'Awesome package'.to_s, count: 1
  end
end
