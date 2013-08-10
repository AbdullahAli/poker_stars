require 'active_model'

class Card
  include ActiveModel::Model

  attr_accessor :rank, :suit
  validates_presence_of :rank, :suit

  def initialize(opts)
    super
    self.rank = opts[:rank]
    self.suit = opts[:suit]
    validate!
  end

  private

  def validate!
    raise Exception.new(self.errors.messages) if !self.valid?
  end
end
