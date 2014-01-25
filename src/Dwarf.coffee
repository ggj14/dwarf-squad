#= require Entity

class Dwarf extends Entity
  constructor:(game, i)->
    @sprite = game.add.sprite(0, 0, 'dwarf1')
    @sprite.animations.frame = i
    @sprite.body.friction = 2000
    @sprite.body.maxVelocity.x = 300
    @sprite.body.maxVelocity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.x = 0.4
    @sprite.body.bounce.y = 0.4

    ANIM_FPS_X = 15
    ANIM_FPS_Y = 10
    @sprite.animations.add("down", [0, 1, 2], ANIM_FPS_Y, true)
    @sprite.animations.add("left", [4, 5, 6], ANIM_FPS_X, true)
    @sprite.animations.add("right", [8, 9, 10], ANIM_FPS_X, true)
    @sprite.animations.add("up", [12, 13, 14], ANIM_FPS_Y, true)

    super

  update:=>
    MIN_ANIM_VELOCITY = 30.0

    if @sprite.body.velocity.x > MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("right")
    else if @sprite.body.velocity.x < -MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("left")
    else if @sprite.body.velocity.y > MIN_ANIM_VELOCITY
        @sprite.animations.play("down")
    else if @sprite.body.velocity.y < -MIN_ANIM_VELOCITY
        @sprite.animations.play("up")
    else
        @sprite.animations.stop()

    super


root = exports ? window
root.Dwarf = Dwarf
