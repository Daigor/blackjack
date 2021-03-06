# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  defaults: 
    deck : new Deck()
    player : 1000


  initialize: ->
    @set 'deck', deck = @get('deck')
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'player', @get('player')
    @get('playerHand').on('stand', => 
      @findWinner()
      @newGame())

    @get('playerHand').on('hit', =>
      @bust()) 


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
      @set('player', @get('player') - Number($('.value').val()))
    else if maxDealerScore == playerMaxScore 
      alert "Tie"
      @set('player', Number(@get('player')))
    else  
      alert "Player Wins!"
      @set('player', @get('player') + Number($('.value').val()))
    
  newGame: ->
    $('.game').empty()
    new AppView(model: new App({ 
      deck: @get('deck'),
      player: @get('player')
      })).
      $el.prependTo $('.game')

  bust: ->
    playerScore = @get('playerHand').scores()
    playerMaxScore = @findHigherScore(playerScore)
    if playerMaxScore == 0
      alert "Bust!"
      @set('player', @get('player') - Number($('.value').val()))
      @newGame()

  startGame: ->
    @get('dealerHand').at(1).flip()
    @get('playerHand').at(0).flip()
    @get('playerHand').at(1).flip()

  
  