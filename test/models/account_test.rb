require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  let(:account) { FactoryGirl.build(:account) }

  it 'validates subdomain format' do
    account.subdomain = ''
    account.valid?.must_equal false

    account.subdomain = 'ab'
    account.valid?.must_equal false

    account.subdomain = '---'
    account.valid?.must_equal false

    account.subdomain = 'ab-'
    account.valid?.must_equal false

    account.subdomain = '-ab'
    account.valid?.must_equal false

    account.subdomain = '1abc'
    account.valid?.must_equal false

    account.subdomain = 'abc1'
    account.valid?.must_equal true

    account.subdomain = 'abc'
    account.valid?.must_equal true

    account.subdomain = 'a-b1c'
    account.valid?.must_equal true
  end

  it 'checks for subdomain uniqueness' do
    account.save!
    a = FactoryGirl.build(:account)
    a.valid?.must_equal true

    a.subdomain = account.subdomain
    a.valid?.must_equal false
  end
end
