#= require Walker

class Sheep extends Walker
  constructor:(game, level)->
    super
    @walkTime = 1.0
    @randDir = 4

  create_sprite:=>
    @sprite = @game.add.sprite(0, 0, 'sheep')

  set_animations: =>
    @min_anim_velocity = 10
    super

  set_physics: =>
    super
    @sprite.body.height = 16
    @sprite.body.width = 24
    @sprite.body.offset.x = 4
    @sprite.body.offset.y = 16
    @sprite.body.maxVelocity.x = 30
    @sprite.body.maxVelocity.y = 30

  on_update:=>
    # randomly walks around
    @walkTime -= @game.time.elapsed / 1000.0
    if (@walkTime < 0.0)
      @walkTime = 1 + Math.random() * 6.0
      @randDir = Math.floor(Math.random() * 5)

    if (@randDir == 0)
      @accelerate(2000, 0)
    else if (@randDir == 1)
      @accelerate(-2000, 0)
    else if (@randDir == 2)
      @accelerate(0, 2000)
    else if @randDir == 3
      @accelerate(0, -2000)
    else
      @accelerate(0, 0)

root = exports ? window
root.Sheep = Sheep
