#= require Entity
#= require Key
#= require Dwarf

class Door extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @count = 0
    properties.locked = true if properties.locked == undefined
    @is_open = properties.locked != 'y'
    @set_animations()
    @open_sfx = @game.add.sound("button1")
    @close_sfx = @game.add.sound("button2")

  set_animations: =>
    @sprite.animations.add("closed", [1], 1, true)
    @sprite.animations.add("open", [2], 1, true)
    @sprite.animations.play("open")

  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'objects')

  targeted: (msg)=>
    if msg
      @open()
    else
      @close()

  set_physics: =>
    super
    @sprite.body.immovable = true

    # whole tile collision
    @sprite.body.height = 32
    @sprite.body.width = 32
    @sprite.body.offset.x = 0
    @sprite.body.offset.y = 0

  open: ()=>
    if !@is_open
      @is_open = true
      @open_sfx.play()
  close: ()=>
    if @is_open
      @is_open = false
      @close_sfx.play()

  on_update:()=>
    # choose the right visuals
    if !@is_open
      @sprite.animations.play("closed")

      # anyone unlocking?
      if @level.pad.enabled
        # collide with all walkers so they can't get through the door
        @collide(@level.walkers, @player_touching)
    else
      @sprite.animations.play("open")


  player_touching:(door, player)=>
    return unless player instanceof Dwarf
    return if player.exited

    return unless (player.carrying && (player.carrying instanceof Key))
    key = player.carrying

    if @properties.id == undefined || @properties.id == key.properties.target
      # ok unlock!
      @open()

root = exports ? window
root.Door = Door
