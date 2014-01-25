#= require Entity

class Dwarf extends Entity
  constructor:(game, i)->
    @sprite =
      switch i
        when 1
          game.add.sprite(0, 0, 'dwarf1')
        when 2
          game.add.sprite(0, 0, 'dwarf2')
        when 3
          game.add.sprite(0, 0, 'dwarf3')
        when 4
          game.add.sprite(0, 0, 'dwarf4')
    @sprite.animations.frame = 1
    @sprite.body.friction = 2000
    @sprite.body.maxVelocity.x = 300
    @sprite.body.maxVelocity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.x = 0.4
    @sprite.body.bounce.y = 0.4

    @sprite.body.height = 16
    @sprite.body.width = 20
    @sprite.body.offset.x = 6
    @sprite.body.offset.y = 18

    ANIM_FPS_X = 20

    ANIM_FPS_Y = 10
    @sprite.animations.add("down", [0, 1, 2, 1, 0], ANIM_FPS_Y, true)
    @sprite.animations.add("left", [4, 5, 6, 5, 4], ANIM_FPS_X, true)
    @sprite.animations.add("right", [8, 9, 10, 9, 8], ANIM_FPS_X, true)
    @sprite.animations.add("up", [12, 13, 14, 13, 12], ANIM_FPS_Y, true)

    @arrows = [
      game.add.sprite(0, 0, 'arrow'),
      game.add.sprite(0, 0, 'arrow'),
      game.add.sprite(0, 0, 'arrow'),
      game.add.sprite(0, 0, 'arrow')
    ]

    @axisOwner = [i, i, i, i]

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

    
    #@carrying = null
    @carrying = new Key()
    @facing = Pad.UP

    super(game, null, {})
    

  attach:(entity)=>
    @carrying = entity

  accelerate:(ax, ay)=>
    super(ax, ay)
    if ax > 1
      @_set_arrow_frame(1, Pad.RIGHT)

    if ax < -1
      @_set_arrow_frame(3, Pad.LEFT)

    if ay > 1
      @_set_arrow_frame(2, Pad.UP)

    if ay < -1
      @_set_arrow_frame(0, Pad.DOWN)

  _set_arrow_frame:(idx, dir)=>
    @arrows[idx].animations.frame = 4 * @axisOwner[dir] + idx
    @arrows[idx].alpha = 1

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

    @arrows[0].x = @sprite.x + 8
    @arrows[0].y = @sprite.y + 32
    @arrows[1].x = @sprite.x - 16
    @arrows[1].y = @sprite.y + 8
    @arrows[2].x = @sprite.x + 8
    @arrows[2].y = @sprite.y - 16
    @arrows[3].x = @sprite.x + 32
    @arrows[3].y = @sprite.y + 8

    arrow.alpha *= 0.9 for arrow in @arrows

    if @carrying != null
      carrying.move_to(@sprite.x, @sprite.y)


    #do the arrows
    super

  direction_owner:(ctrl_index, player_dir)=>
    console.log(ctrl_index, player_dir)
    @axisOwner[player_dir] = ctrl_index;


root = exports ? window
root.Dwarf = Dwarf
