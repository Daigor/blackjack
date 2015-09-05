class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="bet-button">Bet</button>
    <form class="user-input">
      Bet how Much? : <input type="number"></input>
    </form>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
      @render()
    'click .stand-button': ->  
      @model.get('playerHand').stand()
    'click .bet-button': ->
      console.log(@$('.user-input input').val())
      @model.startGame()
      @model.money()

  initialize: -> 
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

