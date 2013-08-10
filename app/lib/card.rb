require 'active_model'
require './deck'

class Card
  include ActiveModel::Model

  attr_accessor :rank, :suit
  validates_presence_of :rank, :suit
  validates_inclusion_of :rank, :in => Proc.new{ Deck::POSSIBLE_RANKS }
  validates_inclusion_of :suit, :in => Proc.new{ Deck::POSSIBLE_SUITS }

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
