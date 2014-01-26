#= require Walker
#= require Key

class Dwarf extends Walker
  constructor:(game, level, i)->
    super(game, level, i)
    @num = i
    @carrying = null
    @signal = new Phaser.Signal()

  create_sprite:=>
    super
    gfx = "dwarf#{@player_number}"
    @sprite = @game.add.sprite(0, 0, gfx)

  say:(message, callback=null)=>
    @chat_callback = callback
    colors = ['#FF0000', '#FFFF88', '#8888FF', '#88FF88']
    @set_caption(message, 2, 20, colors[@num-1]) 
    timer = @game.time.create(false)
    timer.add(2500, @notify)
    timer.start()

  notify:=>
    @signal.dispatch()

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
