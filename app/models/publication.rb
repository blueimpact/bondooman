class Publication < ActiveRecord::Base
  include TimeScopes

  belongs_to :subscription
  delegate :user, to: :subscription
end
