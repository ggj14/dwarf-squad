#= require Entity

class Carryable extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @carried_by = false

  move_to:(x, y, facing)=>
    if facing == Pad.RIGHT
      x += @sprite.width

    else if facing == Pad.LEFT
      x -= @sprite.width

    else if facing == Pad.DOWN
      y += @sprite.height/2

    else if facing == Pad.UP
      y -= @sprite.height/2

    @sprite.x = x
    @sprite.y = y

  update:()=>
    if @carried_by
      @move_to(@carried_by.sprite.x, @carried_by.sprite.y, @carried_by.facing)
    else if @level.pad.enabled
      @collide(@level.players, @stepped_on)

  stepped_on:(us, player)=>
    # return unless player.group == @level.entities
    if player.maybe_pickup(this)
      @carried_by = player
      if @on_pickup
        on_pickup(player)

root = exports ? window
root.Carryable = Carryable