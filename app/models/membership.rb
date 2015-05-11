class Membership < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  validates :account, :user, presence: true
  validates :role, inclusion: { in: SYSTEM_ROLES }
end
