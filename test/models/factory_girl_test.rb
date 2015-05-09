require 'test_helper'

class FactoryGirlTest < ActiveSupport::TestCase
  it 'lint all factories' do
    FactoryGirl.lint
  end
end
