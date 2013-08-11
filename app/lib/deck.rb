require './card'

class Deck

  #TODO
  #add function to map double digits to letter T,J,Q,K,A
  POSSIBLE_RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
  POSSIBLE_SUITS = %w(C D H S)

  def self.random_card
    #TODO
    #remove drawn cards from possible list of cards to be drawn again
    Card.new(
      :rank => POSSIBLE_RANKS.sample,
      :suit => POSSIBLE_SUITS.sample
    )
  end
end
