#= require Dwarf
#= require Sheep
#= require Controller
#= require Pad
#= require Scene
#= require Exit
#= require Trigger
#= require Skeleton
#= require Switcher
#= require Door
#= require Boulder
#= require Treasure

class Level extends Scene
  init:=>
    @started = false
    @current = null
    @game.stage.backgroundColor = '#000'
    @ready = false
    @signals = {
      start: new Phaser.Signal()
      finish: new Phaser.Signal()
    }
    @levels = [
      'intro',
      'level01',
      'level02',
      'level03',
      'treasure_room'
    ]
    @players = [
      new Dwarf(@game, this, 1),
      new Dwarf(@game, this, 2),
      new Dwarf(@game, this, 3),
      new Dwarf(@game, this, 4)
    ]
    @controllers = []
    for player in @players
      @controllers.push(new Controller(player, @game))

    @pad = new Pad(@game)
    for i in [0..3]
      @flush_directions(i)

    @next()

  next:=>
    @started = false
    @game.world.removeAll() unless @faders

    console.log(@players)

    level_group = if @faders then @faders else @game.add.group()
    @render_order = @game.add.group()
    level_group.addAt(@render_order, 0)
    @faders = null

    @render_order.alpha = 0

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

    background = map.createLayer('Background', undefined, undefined, @render_order)
    scenery = map.createLayer('Scenery', undefined, undefined, @render_order)
    @floor_group = @game.add.group()
    @render_order.add(@floor_group)
    @walls = map.createLayer('Walls', undefined, undefined, @render_order)
    @entities = @game.add.group()
    @render_order.add(@entities)
    roof = map.createLayer('Roof', undefined, undefined, @render_order)

    map.addTilesetImage('world', 'world')

    @triggers = []
    @objects = []
    @walkers = []
    @walkers.push(player) for player in @players

    for player in @players
      player.add_to_group(@entities)

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
        when "object"
          layer = @entities
          o =
            switch spawn.properties.type
              when "exit"
                new Exit(@game, this, spawn.properties)
              when "treasure"
                new Treasure(@game, this, spawn.properties)
              when "key"
                new Key(@game, this, spawn.properties)
              when "door"
                #always underneath
                layer = @floor_group
                new Door(@game, this, spawn.properties)
              when "switch"
                #always underneath
                layer = @floor_group
                new Switcher(@game, this, spawn.properties)
              when "sheep"
                new Sheep(@game, this)
              when "boulder"
                new Boulder(@game, this)
              when "skeleton"
                new Skeleton(@game, this)
              else
                alert("missing definition for type: #{spawn.properties.type}")
          o.sprite.x = spawn.x
          o.sprite.y = spawn.y - o.sprite.height
          @objects.push(o)

          o.add_to_group(layer)
          @walkers.push(o) if (o instanceof Walker)

    for trigger in @triggers
      @signals[trigger.properties.event].add(trigger.handle)


    Controller.flush_directions_all(this)

    @pain = @game.add.sound('pain')
    @fadein()

  fadein:=>
    @game.add.tween(@render_order).to( { alpha: 1 }, 1000, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(1000, @endfade)
    timer.start()

  endfade:=>
    @signals['finish'].addOnce(@fadeout)
    @signals['start'].dispatch()
    @started = true

  fadeout:=>
    @game.add.tween(@render_order).to( { alpha: 0 }, 1000, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(1000, @next)
    timer.start()

  update:=>
    return unless @started
    @pad.update()
    player.update() for player in @players
    object.update() for object in @objects

    # players bonking into each other
    alive_walkers = (walker for walker in @walkers when !walker.ignore)
    walker.collide(alive_walkers, @players_collided) for walker in alive_walkers
    walker.collide(@walls) for walker in alive_walkers

    controller.update() for controller in @controllers
    @entities.sort('y', Phaser.Group.SORT_ASCENDING)

  exchange_direction:(p1, p2, d1, d2)=>
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

  players_collided:(p1, p2) =>
    return if p1.exited || p2.exited

    if p1.sprite.body.speed+p2.sprite.body.speed >= 150
      @pain.play('', 0, 1)

      if p1.is_swapable() and p2.is_swapable()
        p1.cool_down_swap(10.0)
        p2.cool_down_swap(10.0)
        Controller.flip_axis_playable(this, p1.player_number - 1, p2.player_number - 1)

root = exports ? window
root.Level = Level
