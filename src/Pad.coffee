class Pad
  constructor:(game)->
    @game = game
    @enabled = true
    @game.input.gamepad.start();
    @pads = [
      @game.input.gamepad.pad1,
      @game.input.gamepad.pad2,
      @game.input.gamepad.pad3,
      @game.input.gamepad.pad4
    ]
    @kb = @game.input.keyboard
    @kb.addKeyCapture([
      Phaser.Keyboard.W,
      Phaser.Keyboard.A,
      Phaser.Keyboard.S,
      Phaser.Keyboard.D,

      Phaser.Keyboard.G,
      Phaser.Keyboard.V,
      Phaser.Keyboard.B,
      Phaser.Keyboard.N,

      Phaser.Keyboard.O,
      Phaser.Keyboard.K,
      Phaser.Keyboard.L,
      Phaser.Keyboard.COLON,

      Phaser.Keyboard.UP,
      Phaser.Keyboard.DOWN,
      Phaser.Keyboard.LEFT,
      Phaser.Keyboard.RIGHT,
    ])
    @state = [
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null},
      { UP: null, DOWN: null, LEFT: null, RIGHT: null}
    ]
    @enabled = [true, true, true, true]

  enable:=>
    @enabled = [true, true, true, true]

  disable:=>
    @enabled = [false, false, false, false]

  enable_player:(num)=>
    @enabled[num] = true

  on:(index, direction, callback)=>
    @state[index][direction] = callback

  update:=>
    @poll(pad) for pad in @pads
    # LEFT STICK
    if @state[0][Pad.UP] && @kb.isDown(Phaser.Keyboard.W)
      @state[0][Pad.UP](0) if @enabled[0]
    if @state[0][Pad.DOWN] && @kb.isDown(Phaser.Keyboard.S)
      @state[0][Pad.DOWN](0) if @enabled[0]
    if @state[0][Pad.LEFT] && @kb.isDown(Phaser.Keyboard.A)
      @state[0][Pad.LEFT](0) if @enabled[0]
    if @state[0][Pad.RIGHT] && @kb.isDown(Phaser.Keyboard.D)
      @state[0][Pad.RIGHT](0) if @enabled[0]
    # DPAD
    if @state[1][Pad.UP] && @kb.isDown(Phaser.Keyboard.G)
      @state[1][Pad.UP](1) if @enabled[1]
    if @state[1][Pad.DOWN] && @kb.isDown(Phaser.Keyboard.B)
      @state[1][Pad.DOWN](1) if @enabled[1]
    if @state[1][Pad.LEFT] && @kb.isDown(Phaser.Keyboard.V)
      @state[1][Pad.LEFT](1) if @enabled[1]
    if @state[1][Pad.RIGHT] && @kb.isDown(Phaser.Keyboard.N)
      @state[1][Pad.RIGHT](1) if @enabled[1]
    # RIGHT STICK
    if @state[2][Pad.UP] && @kb.isDown(Phaser.Keyboard.O)
      @state[2][Pad.UP](2) if @enabled[2]
    if @state[2][Pad.DOWN] && @kb.isDown(Phaser.Keyboard.L)
      @state[2][Pad.DOWN](2) if @enabled[2]
    if @state[2][Pad.LEFT] && @kb.isDown(Phaser.Keyboard.K)
      @state[2][Pad.LEFT](2) if @enabled[2]
    if @state[2][Pad.RIGHT] && @kb.isDown(Phaser.Keyboard.COLON)
      @state[2][Pad.RIGHT](2) if @enabled[2]
    # BUTTONS
    if @state[3][Pad.UP] && @kb.isDown(Phaser.Keyboard.UP)
      @state[3][Pad.UP](3) if @enabled[3]
    if @state[3][Pad.DOWN] && @kb.isDown(Phaser.Keyboard.DOWN)
      @state[3][Pad.DOWN](3) if @enabled[3]
    if @state[3][Pad.LEFT] && @kb.isDown(Phaser.Keyboard.LEFT)
      @state[3][Pad.LEFT](3) if @enabled[3]
    if @state[3][Pad.RIGHT] && @kb.isDown(Phaser.Keyboard.RIGHT)
      @state[3][Pad.RIGHT](3) if @enabled[3]

  poll:(pad)=>
    # LEFT STICK
    if @state[0][Pad.UP] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) < -Pad.SENSITIVITY
      @state[0][Pad.UP](0) if @enabled[0]
    if @state[0][Pad.DOWN] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_Y) > Pad.SENSITIVITY
      @state[0][Pad.DOWN](0) if @enabled[0]
    if @state[0][Pad.LEFT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) < -Pad.SENSITIVITY
      @state[0][Pad.LEFT](0) if @enabled[0]
    if @state[0][Pad.RIGHT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_LEFT_X) > Pad.SENSITIVITY
      @state[0][Pad.RIGHT](0) if @enabled[0]
    # DPAD
    if @state[1][Pad.UP] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_UP)
      @state[1][Pad.UP](1) if @enabled[1]
    if @state[1][Pad.DOWN] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_DOWN)
      @state[1][Pad.DOWN](1) if @enabled[1]
    if @state[1][Pad.LEFT] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_LEFT)
      @state[1][Pad.LEFT](1) if @enabled[1]
    if @state[1][Pad.RIGHT] && pad.isDown(Phaser.Gamepad.XBOX360_DPAD_RIGHT)
      @state[1][Pad.RIGHT](1) if @enabled[1]
    # RIGHT STICK
    if @state[2][Pad.UP] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) < -Pad.SENSITIVITY
      @state[2][Pad.UP](2) if @enabled[2]
    if @state[2][Pad.DOWN] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_Y) > Pad.SENSITIVITY
      @state[2][Pad.DOWN](2) if @enabled[2]
    if @state[2][Pad.LEFT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) < -Pad.SENSITIVITY
      @state[2][Pad.LEFT](2) if @enabled[2]
    if @state[2][Pad.RIGHT] && pad.axis(Phaser.Gamepad.XBOX360_STICK_RIGHT_X) > Pad.SENSITIVITY
      @state[2][Pad.RIGHT](2) if @enabled[2]
    # BUTTONS
    if @state[3][Pad.UP] && pad.isDown(Phaser.Gamepad.XBOX360_Y)
      @state[3][Pad.UP](3) if @enabled[3]
    if @state[3][Pad.DOWN] && pad.isDown(Phaser.Gamepad.XBOX360_A)
      @state[3][Pad.DOWN](3) if @enabled[3]
    if @state[3][Pad.LEFT] && pad.isDown(Phaser.Gamepad.XBOX360_X)
      @state[3][Pad.LEFT](3) if @enabled[3]
    if @state[3][Pad.RIGHT] && pad.isDown(Phaser.Gamepad.XBOX360_B)
      @state[3][Pad.RIGHT](3) if @enabled[3]

Pad.UP = 0
Pad.RIGHT = 1
Pad.DOWN = 2
Pad.LEFT = 3

Pad.SENSITIVITY = 0.8

root = exports ? window
root.Pad = Pad
