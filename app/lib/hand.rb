require './deck'

class Hand
  attr_accessor :cards, :ranks, :suits

  def initialize
    super
    draw_cards
    self.ranks = self.ranks.sort
  end

  def draw_cards
    self.cards = []
    self.ranks = []
    self.suits = []

    5.times do
      card = Deck.random_card
      self.cards << card
      self.ranks << card.rank
      self.suits << card.suit
    end
  end

  def pair?
  end

  def two_pairs?
    response = [false]
    pair_counter = 0
    highest_pair = 0

    get_rank_appearances.each do |k,v|
      if v >= 2
        if v >= 4
          pair_counter += 2
        else
          pair_counter += 1
        end

        if k > highest_pair
          highest_pair = k
        end
      end
    end

    if pair_counter == 2
      response = [true, highest_pair]
    end

  end

  def three_of_a_kind?
    response = [false]
    is_3_of_a_kind, highest_number = has_recurrences_of?(3)

    if is_3_of_a_kind
      response = [true, highest_number]
    end

  end

  def straight?
    response = [false]
    is_consecutive = consecutive?

    if is_consecutive
      response = [true, get_highest_card]
    end

  end

  def flush?
    response = [false]

    if all_same_suit?
      response = [true, get_highest_card]
    end

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

  end

  def four_of_a_kind?
    response = [false]
    get_rank_appearances.any? do |k,v|
      if v == 4
        response = [true, k]
      end
    end

  end

  def straight_flush?
    response = [false]
    is_straight_flush = (consecutive? && all_same_suit?)

    if is_straight_flush
      response = [consecutive? && all_same_suit?, get_highest_card]
    end

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
end
