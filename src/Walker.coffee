#= require Actor

class Walker extends Actor
  constructor:(game, level)->
    @level = level
    super(game)
    @anim_fps_x = 20
    @anim_fps_y = 10
    @min_anim_velocity = 29.0
    @set_animations()
    @ignore = false

  set_animations: =>
    @sprite.animations.frame = 1
    @sprite.animations.add("down", [0, 1, 2, 1], @anim_fps_y, true)
    @sprite.animations.add("left", [4, 5, 6, 5], @anim_fps_x, true)
    @sprite.animations.add("right", [8, 9, 10, 9], @anim_fps_x, true)
    @sprite.animations.add("up", [12, 13, 14, 13], @anim_fps_y, true)

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

    if @sprite.body.velocity.x > @min_anim_velocity && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
      @sprite.animations.play("right")
      @facing = Pad.RIGHT

    else if @sprite.body.velocity.x < -@min_anim_velocity && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
      @sprite.animations.play("left")
      @facing = Pad.LEFT

    else if @sprite.body.velocity.y > @min_anim_velocity
      @sprite.animations.play("down")
      @facing = Pad.DOWN

    else if @sprite.body.velocity.y < -@min_anim_velocity
      @sprite.animations.play("up")
      @facing = Pad.UP
    else
      @sprite.animations.play("idle")
      @facing = Pad.DOWN


    super

  on_walking_collide:(us, them)=>
    return false unless them.solid
    return true


root = exports ? window
root.Walker = Walker