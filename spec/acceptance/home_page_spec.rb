require 'spec_helper'
require 'acceptance_helper'

describe 'the home page', :type => :feature do
  it 'will go to the home page' do
    visit '/'
    within 'dl.information' do
      page.should have_css('dd.test-me', :text => 'Hello!')
    end
  end
end
