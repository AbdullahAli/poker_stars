require 'active_model'
require './deck'

class Hand
  include ActiveModel::Model
  attr_accessor :cards, :ranks, :suits

  def initialize
    super
    test_helper
  end

  def full_house?
    response = [false]
    rank_appearances = get_rank_appearances
    is_3_with_same_value, highest_number = has_recurrences_of?(3)
    rank_appearances.delete(highest_number)

    if is_3_with_same_value
      if rank_appearances.values.first == 2
        response = [true, highest_number]
      end
    end
    response
  end

  def four_of_a_kind?
    response = [false]
    get_rank_appearances.any? do |k,v|
      if v == 4
        response = [true, k]
      end
    end

    response
  end

  def straight_flush?
    response = [false]
    is_straight_flush = (consecutive? && all_same_suit?)

    if is_straight_flush
      response = [consecutive? && all_same_suit?, get_highest_card]
    end

    response
  end

  private

  def has_recurrences_of?(required_count)
    response = [false]
    matched = false
    highest_number = 0

    get_rank_appearances(ranks).each do |k,v|
      if v >= required_count
        matched = true

        if k > highest_number
          highest_number = k
        end
      end
    end

    if matched
      response = [true, highest_number]
    end

    response
  end

  def consecutive?
    self.ranks.each_cons(2).all? { |c1, c2| c1 == (c2 - 1)}
  end

  def get_rank_appearances(ranks = {})
    ranks = ranks.empty? ? self.ranks : ranks
    ranks.inject(Hash.new(0)) { |t, e| t[e] += 1; t }
  end

  def all_same_suit?
    suits.uniq.size == 1
  end

  def get_highest_card
    self.ranks.last
  end

  # since time does not allow for writing tests
  def test_helper
    self.cards = []
    self.ranks = []
    self.suits = []

    card = Card.new(:suit => 'C', :rank => 2)
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    card = Card.new(:suit => 'C', :rank => 4)
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    card = Card.new(:suit => 'C', :rank => 4)
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    card =  Card.new(:suit => 'C', :rank => 4)
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    card =  Card.new(:suit => 'H', :rank => 2)
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    self.ranks = self.ranks.sort
  end
end
