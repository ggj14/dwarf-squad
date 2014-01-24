class Pad
  constructor:(game)->
    @game = game
    @game.input.gamepad.start();
    @pads = [
      @game.input.gamepad.pad1,
      @game.input.gamepad.pad2,
      @game.input.gamepad.pad3,
      @game.input.gamepad.pad4
    ]
    @state = [
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null}
    ]

  on:(index, direction, callback)=>
    @state[index][direction] = callback

  update:=>
    @poll(pad) for pad in @pads

  poll:(pad)=>
    # LEFT STICK
    if @state[0][Pad.UP] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -0.3
      @state[0][Pad.UP]()
    if @state[0][Pad.DOWN] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > 0.3
      @state[0][Pad.DOWN]()
    if @state[0][Pad.LEFT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -0.3
      @state[0][Pad.LEFT]()
    if @state[0][Pad.RIGHT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > 0.3
      @state[0][Pad.RIGHT]()
    # DPAD
    if @state[1][Pad.UP] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_UP)
      @state[1][Pad.UP]()
    if @state[1][Pad.DOWN] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_DOWN)
      @state[1][Pad.DOWN]()
    if @state[1][Pad.LEFT] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT)
      @state[1][Pad.LEFT]()
    if @state[1][Pad.RIGHT] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT)
      @state[1][Pad.RIGHT]()
    # RIGHT STICK
    if @state[2][Pad.UP] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) < -0.3
      @state[2][Pad.UP]()
    if @state[2][Pad.DOWN] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) > 0.3
      @state[2][Pad.DOWN]()
    if @state[2][Pad.LEFT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) < -0.3
      @state[2][Pad.LEFT]()
    if @state[2][Pad.RIGHT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) > 0.3
      @state[2][Pad.RIGHT]()
    # BUTTONS
    if @state[3][Pad.UP] && pad.isDown(Phaser.Gamepad.XBOX360_Y)
      @state[3][Pad.UP]()
    if @state[3][Pad.DOWN] && pad.isDown(Phaser.Gamepad.XBOX360_A)
      @state[3][Pad.DOWN]()
    if @state[3][Pad.LEFT] && pad.isDown(Phaser.Gamepad.XBOX360_X)
      @state[3][Pad.LEFT]()
    if @state[3][Pad.RIGHT] && pad.isDown(Phaser.Gamepad.XBOX360_B)
      @state[3][Pad.RIGHT]()

Pad.UP = 0
Pad.DOWN = 1
Pad.LEFT = 2
Pad.RIGHT = 3

root = exports ? window
root.Pad = Pad
