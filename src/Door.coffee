#= require Entity
#= require Key
#= require Dwarf

class Door extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @count = 0
    @open = properties.locked != 'y'
    @set_animations()

  set_animations: =>
    @sprite.animations.add("closed", [1], 1, true)
    @sprite.animations.add("open", [2], 1, true)
    @sprite.animations.play("open")

  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'objects')

  targeted: (msg)=>
    if msg
      @open = true
    else
      @open = false

  set_physics: =>
    super
    @sprite.body.immovable = true

    # whole tile collision
    @sprite.body.height = 32
    @sprite.body.width = 32
    @sprite.body.offset.x = 0
    @sprite.body.offset.y = 0

  on_update:()=>
    if !@open
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
      @open = true

root = exports ? window
root.Door = Door
