#= require Entity

class Door extends Entity
  constructor:(game, level, properties)->
    @sprite = game.add.sprite(0, 0, 'dwarf1')
    @sprite.body.immovable = true
    @count = 0
    super(game, level, properties)

  update:()=>
    if @level.pad.enabled
      @collide(@level.players, @player_entered)

  player_entered:(@door, @player)=>
    return unless @player.group == @level.entities
    @level.entities.remove(@player)
    @count += 1
    if @count == +@properties['count']
      @level.signals[@properties['id']].dispatch()

root = exports ? window
root.Door = Door
