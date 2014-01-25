#= require Walker

directions = (touching)->
  allow = []
  if not touching.up
    allow.push(Phaser.UP)

  if not touching.down
    allow.push(Phaser.DOWN)

  if not touching.left
    allow.push(Phaser.LEFT)

  if not touching.right
    allow.push(Phaser.RIGHT)

  return allow

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

    if (@walkTime < 0.0) or not @sprite.body.wasTouching.none
      console.log(@sprite.body.wasTouching)
      @sprite.body.velocity.equals(0.0, 0.0)

      @walkTime = 1 + Math.random() * 6.0
      @randDir = Phaser.Math.getRandom(directions(@sprite.body.wasTouching))

    if (@randDir == Phaser.RIGHT)
      @accelerate(2000, 0)

    else if (@randDir == Phaser.LEFT)
      @accelerate(-2000, 0)

    else if (@randDir == Phaser.UP)

      @accelerate(0, 2000)
    
    else if @randDir == Phaser.DOWN
      @accelerate(0, -2000)
    else
      @accelerate(0, 0)

root = exports ? window
root.Sheep = Sheep
