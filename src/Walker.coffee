#= require Actor

class Walker extends Actor
  constructor:(game)->
    super(game)
    @set_animations()

  set_animations: =>
    ANIM_FPS_X = 20
    ANIM_FPS_Y = 10
    @sprite.animations.frame = 1
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

  update:=>
    MIN_ANIM_VELOCITY = 10.0
    if @sprite.body.velocity.x > MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
      @sprite.animations.play("right")
      @facing = Pad.RIGHT

    else if @sprite.body.velocity.x < -MIN_ANIM_VELOCITY && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
      @sprite.animations.play("left")
      @facing = Pad.LEFT

    else if @sprite.body.velocity.y > MIN_ANIM_VELOCITY
      @sprite.animations.play("down")
      @facing = Pad.DOWN

    else if @sprite.body.velocity.y < -MIN_ANIM_VELOCITY
      @sprite.animations.play("up")
      @facing = Pad.UP
    else
      @sprite.animations.play("idle")
      @facing = Pad.DOWN
    super


root = exports ? window
root.Walker = Walker