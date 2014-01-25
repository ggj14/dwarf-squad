#= require Entity

class Dwarf extends Entity
  constructor:(game, i)->
    @sprite = game.add.sprite(0, 0, 'dwarf1')
    @sprite.body = null
    @sprite.animations.frame = i

    # @sprite.body.friction = 2000
    # @sprite.body.maxVelocity.x = 300
    # @sprite.body.maxVelocity.y = 300
    # @sprite.body.collideWorldBounds = true
    # @sprite.body.bounce.x = 0.4
    # @sprite.body.bounce.y = 0.4

    ANIM_FPS_X = 20
    ANIM_FPS_Y = 10
    @sprite.animations.add("down", [0, 1, 2, 1, 0], ANIM_FPS_Y, true)
    @sprite.animations.add("left", [4, 5, 6, 5, 4], ANIM_FPS_X, true)
    @sprite.animations.add("right", [8, 9, 10, 9, 8], ANIM_FPS_X, true)
    @sprite.animations.add("up", [12, 13, 14, 13, 12], ANIM_FPS_Y, true)

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

    super

  update:=>
    MIN_ANIM_VELOCITY = 10.0

    # if @sprite.body.velocity.x > MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
    #     @sprite.animations.play("right")
    # else if @sprite.body.velocity.x < -MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
    #     @sprite.animations.play("left")
    # else if @sprite.body.velocity.y > MIN_ANIM_VELOCITY
    #     @sprite.animations.play("down")
    # else if @sprite.body.velocity.y < -MIN_ANIM_VELOCITY
    #     @sprite.animations.play("up")
    # else
    #     @sprite.animations.play("idle")

    super


root = exports ? window
root.Dwarf = Dwarf
