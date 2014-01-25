#= require Candy
#= require Controller
#= require Pad

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:(fullscreen)->
    super
    @launch_fullscreen = fullscreen

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
    scenery = map.createLayer('Scenery')
    @walls = map.createLayer('Walls')
    roof = map.createLayer('Roof')

    @players = []
    @controllers = []

    for spawn in map.objects.Spawns
      switch spawn.name
        when "player"
          player = new Candy(@game, spawn.x, spawn.y, +spawn.properties.id)
          @players.push(player)
          @controllers.push(new Controller(player, @game))

    @entities = @game.add.group()
    @entities.add(player.sprite) for player in @players

    render_order = @game.add.group()
    render_order.add(background)
    render_order.add(scenery)
    render_order.add(@walls)
    render_order.add(@entities)
    render_order.add(roof)

    @pad = new Pad(@game)
    for controller, i in @controllers
      @pad.on(i, Pad.UP, controller.up)
      @pad.on(i, Pad.DOWN, controller.down)
      @pad.on(i, Pad.LEFT, controller.left)
      @pad.on(i, Pad.RIGHT, controller.right)

    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    if @launch_fullscreen
      @game.input.onDown.add(@gofull);

  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    @pad.update()
    player.collide(@players) for player in @players
    player.collide(@walls) for player in @players
    controller.update() for controller in @controllers
    @entities.sort('y', Phaser.Group.SORT_ASCENDING)

root = exports ? window
root.Main = Main
