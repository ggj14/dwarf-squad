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
    @sprite.body.width = 16
    @sprite.body.offset.x = 8
    @sprite.body.offset.y = 8

    ANIM_FPS_X = 10
    ANIM_FPS_Y = 8
    @sprite.animations.add("down", [0, 1, 2, 1], ANIM_FPS_Y, true)
    @sprite.animations.add("left", [3, 4, 5, 4], ANIM_FPS_X, true)
    @sprite.animations.add("right", [6, 7, 8, 7], ANIM_FPS_X, true)
    @sprite.animations.add("up", [9, 10, 11, 10], ANIM_FPS_Y, true)

    idleChoice = Math.floor(Math.random() * 4)
    idleFps = 0.05 + (Math.random() * 0.2)

    if idleChoice == 0
        @sprite.animations.add("idle", [1, 4, 7], idleFps, true)
    else if idleChoice == 1
        @sprite.animations.add("idle", [1, 7, 4], idleFps, true)
    else if idleChoice == 3
        @sprite.animations.add("idle", [1, 4, 1, 7, 1, 4], idleFps, true)
    else
        @sprite.animations.add("idle", [1, 7, 1, 4, 1, 7], idleFps, true)

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
