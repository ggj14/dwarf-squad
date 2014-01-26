#= require Entity
#= require Key
#= require Dwarf
#= require Door

class Treasure extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties

  create_sprite: =>
    super
    @sprite = @game.add.sprite(0, 0, 'world')
    @sprite.animations.add("idle", [Phaser.Math.getRandom([32,33,34])], 1, true)
    @sprite.animations.play("idle")

  set_physics: =>
    super
    @sprite.body.immovable = true

    @sprite.body.width = 22
    @sprite.body.height = 22
    @sprite.body.offset.x = 5
    @sprite.body.offset.y = 5

  on_update:()=>
    @collide(@level.players, null, @player_touching)

  player_touching:(sw, player)=>
    return if player.exited
    @destroy()
    # check treasures left
    treasures = (object for object in @level.objects when (object instanceof Treasure) && !object.dead)
    if treasures.length == 0
      @level.signals['finish'].dispatch()
    return false

root = exports ? window
root.Treasure = Treasure
