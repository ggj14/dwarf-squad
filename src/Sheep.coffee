#= require Entity

class Sheep extends Entity
  constructor:(game, i)->
    @sprite = game.add.sprite(0, 0, 'sheep')

    @sprite.animations.frame = 1
    @sprite.body.friction = 2000
    @sprite.body.maxVelocity.x = 30
    @sprite.body.maxVelocity.y = 30
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.x = 0.4
    @sprite.body.bounce.y = 0.4

    @sprite.body.height = 16
    @sprite.body.width = 24
    @sprite.body.offset.x = 4
    @sprite.body.offset.y = 16

    ANIM_FPS_X = 10
    ANIM_FPS_Y = 8
    @sprite.animations.add("down", [0, 1, 2, 1], ANIM_FPS_Y, true)
    @sprite.animations.add("left", [4, 5, 6, 5], ANIM_FPS_X, true)
    @sprite.animations.add("right", [8, 9, 10, 9], ANIM_FPS_X, true)
    @sprite.animations.add("up", [12, 13, 14, 13], ANIM_FPS_Y, true)

    idleChoice = Math.floor(Math.random() * 4)
    idleFps = 0.05 + (Math.random() * 0.2)

    if idleChoice == 0
        @sprite.animations.add("idle", [1, 5, 9], idleFps, true)
    else if idleChoice == 1
        @sprite.animations.add("idle", [1, 9, 5], idleFps, true)
    else if idleChoice == 3
        @sprite.animations.add("idle", [1, 5, 1, 9, 1, 5], idleFps, true)
    else
        @sprite.animations.add("idle", [1, 9, 1, 5, 1, 9], idleFps, true)

    @walkTime = 1.0
    @randDir = 4


    super(game, null, {})

  accelerate:(ax, ay)=>
    super(ax, ay)

  update:=>

    #console.log @walkTime
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


    MIN_ANIM_VELOCITY = 10.0

    if @sprite.body.velocity.x > MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("right")

    else if @sprite.body.velocity.x < -MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("left")

    else if @sprite.body.velocity.y > MIN_ANIM_VELOCITY
        @sprite.animations.play("down")

    else if @sprite.body.velocity.y < -MIN_ANIM_VELOCITY
        @sprite.animations.play("up")

    else
        @sprite.animations.play("idle")

    super


root = exports ? window
root.Sheep = Sheep
