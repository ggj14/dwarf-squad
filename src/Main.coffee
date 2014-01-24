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


    @axes = [
      [
        [ (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) < -0.1),
          (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) > 0.1) ],
        [ (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) < -0.1),
          (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) > 0.1) ]
      ],
      [
        [ (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.1),
          (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.1) ],
        [ (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -0.1),
          (=> @gamepad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > 0.1) ]
      ],
      [
        [ (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT)),
          (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT)) ],
        [ (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_DPAD_UP)),
          (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_DPAD_DOWN)) ]
      ],
      [
        [ (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_X)),
          (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_B)) ],
        [ (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_Y)),
          (=> @gamepad.isDown(Phaser.Gamepad.XBOX360_A)) ]
      ]
    ]


    # PLAYER 1
    @controller1 = new Controller(@p1, @game)
    @controller1.left =   @axes[0][0][0]
    @controller1.right =  @axes[0][0][1]
    @controller1.up =     @axes[1][1][0]
    @controller1.down =   @axes[1][1][1]


    # PLAYER 2
    @controller2 = new Controller(@p2, @game)
    @controller2.left =   @axes[1][0][0]
    @controller2.right =  @axes[1][0][1]
    @controller2.up =     @axes[2][1][0]
    @controller2.down =   @axes[2][1][1]

    # PLAYER 3
    @controller3 = new Controller(@p3, @game)
    @controller3.left =   @axes[2][0][0]
    @controller3.right =  @axes[2][0][1]
    @controller3.up =     @axes[3][1][0]
    @controller3.down =   @axes[3][1][1]

    # PLAYER 4
    @controller4 = new Controller(@p4, @game)
    @controller4.left =   @axes[3][0][0]
    @controller4.right =  @axes[3][0][1]
    @controller4.up =     @axes[0][1][0]
    @controller4.down =   @axes[0][1][1]

  update: ()=>
    @controller1.update()
    @controller2.update()
    @controller3.update()
    @controller4.update()


