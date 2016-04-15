module TimeScopes
  extend ActiveSupport::Concern

  included do
    scope :old_first, -> { order(created_at: :asc) }
    scope :new_first, -> { order(created_at: :desc) }
    scope :updated_first, -> { order(update_at: :asc) }
    scope :outdated_first, -> { order(update_at: :desc) }
  end

  module ClassMethods
    def newest *args
      new_first.first(*args)
    end

    def oldest *args
      old_first.first(*args)
    end

    def most_updated *args
      updated_first(*args)
    end

    def most_outdated *args
      outdated_first(*args)
    end
  end
end
