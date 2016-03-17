class User < ActiveRecord::Base
  include Ubermenschable

  store_accessor :raw, :email, :role, :name, :letter, :color

  delegate :member?, :admin?, to: :role

  def role
    super.try :inquiry
  end

  def to_s
    name || email
  end
end
