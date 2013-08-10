require 'active_model'
require './deck'

class Hand
  include ActiveModel::Model
  attr_accessor :cards, :ranks, :suits

  def consecutive?
    self.ranks.each_cons(2).all? { |c1, c2| c1 == (c2 - 1)}
  end
end
