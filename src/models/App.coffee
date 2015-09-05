# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  defaults: 
    deck : new Deck()

  initialize: ->
    @set 'deck', deck = @get('deck')
    console.log(@get('deck'))
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @.get('playerHand').on('stand', => 
      @findWinner()
      @newGame()) 


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
    else if maxDealerScore == playerMaxScore 
      alert "Tie"
    else  
      alert "Player Wins!"
    
  newGame: ->
    $('.game').empty()
    new AppView(model: new App({deck: @get('deck')})).$el.prependTo $('.game')