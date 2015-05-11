require "test_helper"

describe DashboardsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:account) { FactoryGirl.create(:account, owner: user) }

  it 'redirects to sign in user is not signed in' do
    request.host = 'subdomain.lvh.me'

    get :show

    must_respond_with :redirect
    must_redirect_to new_user_session_url(subdomain: 'subdomain')
  end

  describe 'for signed in user' do
    before do
      account # preload
      sign_in user
    end

    it 'renders show template if user is signed in' do
      request.host = "#{account.subdomain}.lvh.me"

      get :show

      must_respond_with :success
      must_render_template :show
    end

    it 'redirects to subdomain if subdomain is absent for signed in user' do
      request.host = 'lvh.me'

      get :show

      must_redirect_to "http://#{account.subdomain}.lvh.me/"
    end

    it 'redirect to proper subdomain' do
      request.host = "wrong.lvh.me"

      get :show

      must_redirect_to "http://#{account.subdomain}.lvh.me/"
    end
  end
end
