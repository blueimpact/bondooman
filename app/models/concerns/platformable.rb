module Platformable
  extend ActiveSupport::Concern

  included do
    validates :platform_name, inclusion: Platform::NAMES

    Platform::NAMES.each do |name|
      scope name.to_sym, -> { where(platform_name: name) }
    end
  end

  def platform
    Platform[platform_name]
  end

  def platform= arg
    self.platform_name = arg.is_a?(Platform) ? arg.name : arg
  end
end
