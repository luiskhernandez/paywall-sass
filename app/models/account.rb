class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :lockable
  devise :confirmable, allow_unconfirmed_access_for: 1.month

  validates :domain, uniqueness: true, if: 'domain.present?'
  validates :subdomain, uniqueness: true
  validates :name, uniqueness: true

  after_create :create_tenant
  after_destroy :destroy_tenant

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def destroy_tenant
    Apartment::Tenant.drop(subdomain)
  end
end
