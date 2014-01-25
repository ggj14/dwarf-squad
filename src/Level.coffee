#= require Dwarf
#= require Controller
#= require Pad
#= require Scene
#= require Door

class Level extends Scene
  init:=>
    @ready = false
    @current = null
    @signals = {
      start: new Phaser.Signal()
      finish: new Phaser.Signal()
    }
    @levels = [
      'level01',
      'level02'
    ]
    @players = [
      new Dwarf(@game, 1),
      new Dwarf(@game, 2),
      new Dwarf(@game, 3),
      new Dwarf(@game, 4)
    ]
    @controllers = []
    for player in @players
      @controllers.push(new Controller(player, @game))

    @pad = new Pad(@game)
    for i in [0..3]
      @flush_directions(i)

    @next()

  next:=>
    @game.world.removeAll()
    if @current == null
      @current = 0
    else
      @current += 1
      @current = 0 if @current > @levels.length-1
    map = @game.add.tilemap(@levels[@current])

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

    map.addTilesetImage('world', 'world')
    background = map.createLayer('Background')
    scenery = map.createLayer('Scenery')
    @walls = map.createLayer('Walls')
    roof = map.createLayer('Roof')

    @triggers = []
    @objects = []

    for spawn in map.objects.Spawns
      switch spawn.name
        when "player"
          player = @players[+spawn.properties.id-1]
          player.sprite.x = spawn.x
          player.sprite.y = spawn.y - player.sprite.height
        when "trigger"          
          trigger = new Trigger(@game, this, spawn.properties)
          if trigger.properties.id != null
            @signals[trigger.properties.id] ||= trigger.signal
          @triggers.push(trigger)
        when "door"  
          door = new Door(@game, this, spawn.properties)
          door.sprite.x = spawn.x
          door.sprite.y = spawn.y - door.sprite.height
          @objects.push(door)

    for trigger in @triggers      
      @signals[trigger.properties.event].add(trigger.handle)

    @entities = @game.add.group()
    for player in @players
      @entities.add(player.sprite)
      @entities.add(arrow) for arrow in player.arrows
    @entities.add(object.sprite) for object in @objects

    render_order = @game.add.group()
    render_order.add(background)
    render_order.add(scenery)
    render_order.add(@walls)
    render_order.add(@entities)
    render_order.add(roof)

    @pain = @game.add.sound('pain')

    @signals['finish'].addOnce(@next)
    @signals['start'].dispatch()

  update:=>
    @pad.update()
    player.update() for player in @players
    object.update() for object in @objects
    player.collide(@players, @players_collided) for player in @players
    player.collide(@walls) for player in @players
    controller.update() for controller in @controllers
    @entities.sort('y', Phaser.Group.SORT_ASCENDING)

  exchange_direction:(p1, p2, d1, d2)=>
    console.log(p1, p2, d1, d2)
    @controllers[p1].set_direction_ctrl(@pad, p2, d2, d1)
    @controllers[p2].set_direction_ctrl(@pad, p1, d1, d2)

    #@pad.on(p1, d1, @controllers[p2].getAction(d2))
    #@pad.on(p2, d2, @controllers[p1].getAction(d1))

  flush_directions:(p)=>
    for i in Controller.DIRECTIONS
      @controllers[p].set_direction_ctrl(@pad, p, i, i)

      #@pad.on(p, Pad.UP, @controllers[p].up)
      #@pad.on(p, Pad.DOWN, @controllers[p].down)
      #@pad.on(p, Pad.LEFT, @controllers[p].left)
      #@pad.on(p, Pad.RIGHT, @controllers[p].right)

  players_collided:(@p1, @p2) =>
    if @p1.body.speed+@p2.body.speed >= 500
      @pain.play('', 0, 1)

root = exports ? window
root.Level = Level