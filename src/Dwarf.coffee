#= require Walker
#= require Key

class Dwarf extends Walker
  constructor:(game, level, i)->
    @dwarf_number = i
    super(game, level)

    @carrying = null

  create_sprite:=>
    super
    gfx = "dwarf#{@dwarf_number}"
    @sprite = @game.add.sprite(0, 0, gfx)

  on_add_to_group:(group)=>
    # also need to add our arrooows
    group.add(arrow) for arrow in @arrows

  on_remove_from_group:(group)=>
    # also need to remove our arrooows
    group.remove(arrow) for arrow in @arrows
    if @carrying
      @carrying.remove_from_group(group)

  maybe_pickup:(entity)=>
    if @carrying == null
      @carrying = entity


root = exports ? window
root.Dwarf = Dwarf
