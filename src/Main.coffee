//= require Candy
//= require Controller

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor: ->
    super

  preload: ()=>
    @game.load.spritesheet('candy', 'assets/candy.png', 35, 35)

  create: ()=>
    @p1 = new Candy(@game, 250, 250, 1)
    @p2 = new Candy(@game, 500, 500, 2)
    @p3 = new Candy(@game, 250, 500, 3)
    @p4 = new Candy(@game, 500, 250, 4)

    @game.input.gamepad.start();

    # To listen to buttons from a specific pad listen directly on that pad game.input.gamepad.padX, where X = pad 1-4
    @gamepad = @game.input.gamepad.pad1;


    # PLAYER 1
    @controller1 = new Controller(@p1, @game)
    @controller1.left = =>
      @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1
    @controller1.right = =>
      @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1
    @controller1.up = =>
      @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -0.1
    @controller1.down = =>
      @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > 0.1

  update: ()=>
    @controller1.update()

root = exports ? window
root.Main = Main
