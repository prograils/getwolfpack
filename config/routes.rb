class SubdomainRequired
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end

Rails.application.routes.draw do
  devise_for :users

  resource :account, only: [:new, :create]

  constraints SubdomainRequired do
    root to: 'dashboards#show', as: 'subdomain_root'
  end

  root to: 'welcome#index'
end
