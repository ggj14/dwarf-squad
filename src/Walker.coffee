#= require Actor

class Walker extends Actor
  constructor:(game, level, player_number = -1)->
    @player_number = player_number
    @level = level
    super(game)
    @anim_fps_x = 20
    @anim_fps_y = 10
    @min_anim_velocity = 29.0
    @set_animations()
    @ignore = false
    @animStartTime = 1.0

    @axisOwner = [-1, -1, -1, -1]
    @exited = false
    @facing = Pad.UP

  create_sprite:=>
    super
    @arrows = [
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow')
    ]

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

    if @animStartTime > -1.0
      @animStartTime -= @game.time.elapsed

    if (@animStartTime < 0.0)

      newAnim = false

      if @sprite.body.velocity.x > @min_anim_velocity && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("right")
        @facing = Pad.RIGHT
        newAnim = true

      else if @sprite.body.velocity.x < -@min_anim_velocity && Math.abs(@sprite.body.velocity.x) > Math.abs(@sprite.body.velocity.y)
        @sprite.animations.play("left")
        @facing = Pad.LEFT
        newAnim = true

      else if @sprite.body.velocity.y > @min_anim_velocity
        @sprite.animations.play("down")
        @facing = Pad.DOWN
        newAnim = true

      else if @sprite.body.velocity.y < -@min_anim_velocity
        @sprite.animations.play("up")
        @facing = Pad.UP
        newAnim = true
      else
        @sprite.animations.play("idle")
        @facing = Pad.DOWN
        newAnim = false

      if newAnim
        @animStartTime = 250     #ms before next anim can start

    @arrows[0].x = @sprite.x + 8
    @arrows[0].y = @sprite.y + 32
    @arrows[1].x = @sprite.x - 16
    @arrows[1].y = @sprite.y + 8
    @arrows[2].x = @sprite.x + 8
    @arrows[2].y = @sprite.y - 16
    @arrows[3].x = @sprite.x + 32
    @arrows[3].y = @sprite.y + 8

    arrow.alpha *= 0.9 for arrow in @arrows
    super

  on_walking_collide:(us, them)=>
    return false unless them.solid
    return true

  accelerate:(ax, ay)=>
    super(ax, ay)
    if ax > 1
      @_set_arrow_frame(Pad.RIGHT)

    if ax < -1
      @_set_arrow_frame(Pad.LEFT)

    if ay > 1
      @_set_arrow_frame(Pad.UP)

    if ay < -1
      @_set_arrow_frame(Pad.DOWN)


  is_playable:()=>
    return @player_number != -1

  _set_arrow_frame:(dir)=>
    ARROW_IDX = [2, 0, 3, 1]

    if @axisOwner[dir] != -1
      @arrows[ARROW_IDX[dir]].animations.frame = 4 * @axisOwner[dir] + ARROW_IDX[dir]
      @arrows[ARROW_IDX[dir]].alpha = 1

    else
      @arrows[ARROW_IDX[dir]].alpha = 0 


  direction_owner:(ctrl_index, player_dir)=>
    #console.log(ctrl_index, player_dir)
    @axisOwner[player_dir] = ctrl_index;
    @_set_arrow_frame(player_dir)



root = exports ? window
root.Walker = Walker