# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @.get('playerHand').on('stand', => @findWinner()) 


  findHigherScore: (score) ->
    if score[0] > 21 then score[0] = null
    if score[1] > 21 then score[1] = null
    return Math.max score[0], score[1]
    

  findWinner: =>
    @get('dealerHand').at(0).flip()
    playerScore = @get('playerHand').scores()
    playerMaxScore = @findHigherScore(playerScore)
    dealerScore = @get('dealerHand').scores()
    maxDealerScore = @findHigherScore(dealerScore)
    if maxDealerScore > playerMaxScore
      alert "Dealer wins"
      new AppView(model: new App()).$el.prependTo 'body'
    else if maxDealerScore == playerMaxScore 
      alert "Tie"
      new AppView(model: new App()).$el.prependTo 'body'
    else  
      alert "Player Wins!"
      new AppView(model: new App()).$el.prependTo 'body'