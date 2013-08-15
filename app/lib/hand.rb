require './deck'

class Hand
  attr_accessor :cards, :ranks, :suits

  def initialize
    super
    draw_cards
    self.ranks.sort!
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
    has_recurrences_of?(2)
  end

  def two_pairs?
    response = [false]
    pairs_found = 0
    highest_pair = 0

    rank_appearances.each do |card, occurance|
      if occurance >= 2
        if occurance >= 4
          pairs_found += 2
        else
          pairs_found += 1
        end

        if card > highest_pair
          highest_pair = card
        end
      end
    end

    if pairs_found == 2
      response = [true, highest_pair]
    end

    response
  end

  def three_of_a_kind?
    response = [false]
    three_of_a_kind, highest_card = has_recurrences_of?(3)

    if three_of_a_kind
      response = [true, highest_card]
    end

   response
  end

  def straight?
    response = [false]

    if consecutive?
      response = [true, highest_card]
    end

    response
  end

  def flush?
    response = [false]

    if same_suits?
      response = [true, highest_card]
    end

    response
  end

  def full_house?
    response = [false]
    rank_appearances_result = rank_appearances
    three_with_same_value, highest_card = has_recurrences_of?(3)
    rank_appearances_result.delete(highest_card)

    if three_with_same_value
      if rank_appearances_result.values.first == 2
        response = [true, highest_card]
      end
    end

    response
  end

  def four_of_a_kind?
    response = [false]
    rank_appearances.any? do |card, occurance|
      if occurance == 4
        response = [true, card]
      end
    end

    response
  end

  def straight_flush?
    response = [false]
    is_straight_flush = (consecutive? && same_suits?)

    if is_straight_flush
      response = [consecutive? && same_suits?, highest_card]
    end

    response
  end

  private

  def has_recurrences_of?(required_count)
    response = [false]
    found = false
    highest_card = 0

    rank_appearances(ranks).each do |card, occurance|
      if occurance >= required_count
        found = true

        if card > highest_card
          highest_card = card
        end
      end
    end

    if found
      response = [true, highest_card]
    end

    response
  end

  def consecutive?
    self.ranks.each_cons(2).all? { |card_1, card_2| card_1 == (card_2 - 1)}
  end

  def rank_appearances(ranks = {})
    ranks = ranks.empty? ? self.ranks : ranks
    ranks.inject(Hash.new(0)) { |t, e| t[e] += 1; t }
  end

  def same_suits?
    suits.uniq.size == 1
  end

  def highest_card
    self.ranks.last
  end
end
