class User < ActiveRecord::Base
  include Ubermenschable

  has_many :subscriptions, dependent: :destroy
  has_many :publications, through: :subscriptions

  store_accessor :raw, :email, :role, :name, :letter, :color

  delegate :member?, :admin?, to: :role

  def role
    super.try :inquiry
  end

  def to_s
    name || email
  end
end
