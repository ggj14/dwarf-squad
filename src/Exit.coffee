#= require Entity

class Exit extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @count = 0

  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'key')

  set_physics: =>
    super
    @sprite.body.immovable = true

    # whole tile collision
    @sprite.body.height = 32
    @sprite.body.width = 32
    @sprite.body.offset.x = 0
    @sprite.body.offset.y = 0

  on_update:()=>
    if @level.pad.enabled
      @collide(@level.players, @player_entered)

  player_entered:(door, player)=>
    return unless player.group == @level.entities
    @level.entities.remove(player)
    @count += 1
    @game.add.sound("collect").play('', 0, 1)
    if @count == +@properties['count']
      @level.signals[@properties['id']].dispatch()

root = exports ? window
root.Exit = Exit
