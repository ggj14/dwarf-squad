#= require Candy
#= require Controller
#= require Pad

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:()->
    super

  preload:()=>
    @game.load.spritesheet('candy', 'assets/candy.png', 35, 35)
    @game.load.image('dungeon', 'assets/dungeon.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)

  create:()=>
    @game.stage.backgroundColor = '#FF00FF'
    @game.physics.gravity.y = 0

    map = @game.add.tilemap('level01')

    # had to do this manually; should be this:
    # map.setCollisionByExclusion([], true, 'Walls')
    index = map.getLayerIndex('Walls')
    layer = map.layers[index]
    for y in [0...layer.height]
      for x in [0...layer.width]
        tile = layer.data[y][x]
        if tile && tile.index > 0
          tile.collides = true
          tile.faceTop = true
          tile.faceBottom = true
          tile.faceLeft = true
          tile.faceRight = true
    map.calculateFaces(index)

    map.addTilesetImage('dungeon', 'dungeon')
    background = map.createLayer('Background')
    @walls = map.createLayer('Walls')

    @p1 = new Candy(@game, 250, 250, 1)
    @p2 = new Candy(@game, 500, 500, 2)
    @p3 = new Candy(@game, 250, 500, 3)
    @p4 = new Candy(@game, 500, 250, 4)

    @controller1 = new Controller(@p1, @game)
    @controller2 = new Controller(@p2, @game)
    @controller3 = new Controller(@p3, @game)
    @controller4 = new Controller(@p4, @game)

    @pad = new Pad(@game)
    @pad.on(0, Pad.UP, @controller1.up)
    @pad.on(0, Pad.DOWN, @controller1.down)
    @pad.on(0, Pad.LEFT, @controller1.left)
    @pad.on(0, Pad.RIGHT, @controller1.right)
    @pad.on(1, Pad.UP, @controller2.up)
    @pad.on(1, Pad.DOWN, @controller2.down)
    @pad.on(1, Pad.LEFT, @controller2.left)
    @pad.on(1, Pad.RIGHT, @controller2.right)
    @pad.on(2, Pad.UP, @controller3.up)
    @pad.on(2, Pad.DOWN, @controller3.down)
    @pad.on(2, Pad.LEFT, @controller3.left)
    @pad.on(2, Pad.RIGHT, @controller3.right)
    @pad.on(3, Pad.UP, @controller4.up)
    @pad.on(3, Pad.DOWN, @controller4.down)
    @pad.on(3, Pad.LEFT, @controller4.left)
    @pad.on(3, Pad.RIGHT, @controller4.right)

    @debug = false
    @toggle = false
    @game.input.keyboard.addKeyCapture([
      Phaser.Keyboard.F1
    ])
#   @walls.debug = true

    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    @game.input.onDown.add(@gofull);

  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    if @game.input.keyboard.isDown(Phaser.Keyboard.F1) && !@toggle
      @debug = !@debug
      @toggle = true
    else if !@game.input.keyboard.isDown(Phaser.Keyboard.F1)
      @toggle = false

    @pad.update()

    @p1.collide([@walls, @p2, @p3, @p4])
    @controller1.update()

    @p2.collide([@walls, @p1, @p3, @p4])
    @controller2.update()

    @p3.collide([@walls, @p1, @p2, @p4])
    @controller3.update()

    @p4.collide([@walls, @p1, @p2, @p3])
    @controller4.update()

root = exports ? window
root.Main = Main
