#= require Walker
#= require Key

class Dwarf extends Walker
  constructor:(game, i)->
    @dwarf_number = i
    @axisOwner = [i, i, i, i]
    super(game)

    @carrying = null
    @facing = Pad.UP

  create_sprite:=>
    gfx = "dwarf#{@dwarf_number}"
    @sprite = @game.add.sprite(0, 0, gfx)

    @arrows = [
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow')
    ]

  on_add_to_group:(group)=>
    # also need to add our arrooows
    group.add(arrow) for arrow in @arrows

  maybe_pickup:(entity)=>
    if @carrying == null
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

  on_update:=>
    @arrows[0].x = @sprite.x + 8
    @arrows[0].y = @sprite.y + 32
    @arrows[1].x = @sprite.x - 16
    @arrows[1].y = @sprite.y + 8
    @arrows[2].x = @sprite.x + 8
    @arrows[2].y = @sprite.y - 16
    @arrows[3].x = @sprite.x + 32
    @arrows[3].y = @sprite.y + 8

    arrow.alpha *= 0.9 for arrow in @arrows

    #do the arrows
    super

  direction_owner:(ctrl_index, player_dir)=>
    #console.log(ctrl_index, player_dir)
    @axisOwner[player_dir] = ctrl_index;


root = exports ? window
root.Dwarf = Dwarf
