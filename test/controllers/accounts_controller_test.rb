require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  def account_attributes
    FactoryGirl.attributes_for(:account).
      merge(owner_attributes: FactoryGirl.attributes_for(:user))
  end

  it 'shows new account form' do
     get :new

     must_respond_with :success # 1
     must_render_template :new

     assigns(:account).must_be_instance_of Account
     assigns(:account).owner.must_be_instance_of User
   end

  it 'creates new account' do
    lambda {
      lambda {
        post :create, account: account_attributes
      }.must_change 'User.count', 1
    }.must_change 'Account.count', 1

    must_respond_with :redirect
    must_redirect_to root_url
  end

  it 'renders form for invalid params' do
    post :create, account: { owner_attributes: { first_name: '' } }

    must_render_template :new
  end
end
