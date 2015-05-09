class Account < ActiveRecord::Base
  validates :name, :subdomain, presence: true
  validates :subdomain,
          format: { with: /\A[a-z][a-z0-9\-]+[a-z0-9]\Z/ },
          uniqueness: true
end
