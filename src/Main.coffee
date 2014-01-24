class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor: ->
    super

  preload: ()=>
    @game.load.image('player', 'assets/littlemario.jpg')

  create: ()=>
    @player = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'player')
    @player.anchor.x = 0.5
    @player.anchor.y = 0.5
    # @logo.update = ()->
    #   @angle++

    left = @game.input.keyboard.addKey(Phaser.Keyboard.LEFT);
    left.onDown.add(@moveEntityLeft);

    right = @game.input.keyboard.addKey(Phaser.Keyboard.RIGHT);
    right.onDown.add(@moveEntityRight);

  moveEntityLeft: ()=>
    @player.x -= 100
  moveEntityRight: ()=>
    @player.x += 100
