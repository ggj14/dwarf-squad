#= require Entity
#= require Key
#= require Dwarf
#= require Door

class Switcher extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @set_animations()
    @on = false

  set_animations: =>
    @sprite.animations.add("up", [10], 1, true)
    @sprite.animations.add("down", [11], 1, true)
    @sprite.animations.play("up")

  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'objects')

  set_physics: =>
    super
    @sprite.body.immovable = true

    @sprite.body.width = 22
    @sprite.body.height = 22
    @sprite.body.offset.x = 5
    @sprite.body.offset.y = 5

  on_update:()=>
    if @properties.action == 'momentary'
      @on = false
      @collide(@level.walkers, null, @player_touching)
    else
      alert("#{@properties.action} action switch not supported")

    if @on
      @sprite.animations.play("down")
    else
      @sprite.animations.play("up")

    if @properties.target
      for x in @level.objects
        if x.properties && x.properties.id == @properties.target
          x.targeted @on

  player_touching:(sw, player)=>
    return if player.exited
    @on = true
    return false # don't bounce off it

root = exports ? window
root.Switcher = Switcher
