class Platform
  include ActiveModel::Model

  attr_accessor :name

  NAMES = %w(googleplay appstore)

  def label
    I18n.translate name, scope: :platforms
  end

  def to_s
    label
  end

  class << self
    def initialize
      @instances = NAMES.map do |name|
        [name, new(name: name)]
      end.to_h.with_indifferent_access
    end

    def [] name
      @instances[name]
    end

    def all
      @instances.values
    end

    delegate :first, :last, to: :all

    private :new
  end

  initialize
end
