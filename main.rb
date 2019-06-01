# Ask player's name
  # Everyone has 100$
    # Initialize deck of cards
      # Deal two random cards each to player and dealer
      # Remove the dealt cards from the deck as they are dealt
        # Everyone gives 10$ to Bank
          # Player 'Hits' or 'Stands' or 'BJ'
            # if player stands play moves to Dealer  
            # if player hits then another card is dealt
            # if total > 21 then player busts and dealer wins and receives Bank, else if 16<score<20 player can 'Hit' or 'Stand', else 'Hit' 
            # Remove dealt cards from deck array
              # continue until 'Stand' or 'Bust'
                # Dealer plays if player 'stands' or has BJ
                  # if dealer cards == BJ && players cards == BJ its a push and everyone has half of Bank
                  # else if dealers cards < 16 dealer 'Hits'
                  # else if dealers cards > 16 && <=21 'Stand'
                  # else bust and player has Bank
                    # Result 
                      # play again?

class Main
end
