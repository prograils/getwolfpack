class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :redirect_to_subdomain # 1.

  private

  def redirect_to_subdomain
    return unless user_signed_in? # 2.

    if request.subdomain.blank? # 3.
      if current_user.accounts.any?
        redirect_to root_url(subdomain: current_user.accounts.first.subdomain)
      end
    else # 4.
      unless current_user.accounts.pluck(:subdomain).include?(request.subdomain)
        redirect_to root_url(subdomain: current_user.accounts.first.subdomain)
      end
    end
  end
end
