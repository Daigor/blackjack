# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    


  

  findHigherScore: (score) ->
    if score[0] > 21 then score[0] = null
    if score[1] > 21 then score[1] = null
    return Math.max score[0], score[1]
    

  findWinner: ->
    playerScore = @get('playerHand').scores()
    playerMaxScore = @findHigherScore(playerScore)
    dealerScore = @get('dealerHand').scores()
    console.log(playerScore)
    console.log(dealerScore)
    maxDealerScore = @findHigherScore(dealerScore)
    if maxDealerScore > playerMaxScore then alert "Dealer wins"
    else if maxDealerScore == playerMaxScore then alert "Tie"  
    else  
      alert "Player Wins!"