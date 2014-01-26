#= require Walker

directions = (wasTouching, touching)->
  allow = []
  if not (touching.up or wasTouching.up) 
    allow.push(Phaser.UP)

  if not (touching.down or wasTouching.down)
    allow.push(Phaser.DOWN)

  if not (touching.left or wasTouching.left)
    allow.push(Phaser.LEFT)

  if not (touching.right or wasTouching.right)
    allow.push(Phaser.RIGHT)

  return allow

class Sheep extends Walker
  constructor:(game, level)->
    super
    @walkTime = 1.0
    @randDir = 4
    @sprite.body.bounce.x = 0.0
    @sprite.body.bounce.y = 0.0

  create_sprite:=>
    @sprite = @game.add.sprite(0, 0, 'sheep')

  set_animations: =>
    @min_anim_velocity = 10
    @anim_fps_x = 10
    @anim_fps_y = 10
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

    if (@walkTime < 0.0) or not @sprite.body.wasTouching.none or not @sprite.body.touching
      if Phaser.Math.chanceRoll(20)
        @set_caption("Bleet!", 1.0, 20)
        
      @sprite.body.velocity.equals(0.0, 0.0)

      @walkTime = 1 + Math.random() * 6.0

      #If we hit something always move, otherwise random roll
      if not @sprite.body.wasTouching.none or not @sprite.body.touching or Phaser.Math.chanceRoll(70)
        @randDir = Phaser.Math.getRandom(directions(@sprite.body.wasTouching, @sprite.body.touching))

      else
        @randDir = Phaser.NONE


    if (@randDir == Phaser.RIGHT)
      @accelerate(20, 0)

    else if (@randDir == Phaser.LEFT)
      @accelerate(-20, 0)

    else if (@randDir == Phaser.UP)
      @accelerate(0, 20)
    
    else if @randDir == Phaser.DOWN
      @accelerate(0, -20)

    else
      @accelerate(0, 0)

root = exports ? window
root.Sheep = Sheep
