module StiBecome
  extend ActiveSupport::Concern

  included do
    klass = self
    define_method :unbecome do
      becomes klass
    end

    def rebecome
      becomes type.constantize
    end

    def become?
      self.class.name == type
    end
  end
end
