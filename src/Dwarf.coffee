#= require Walker
#= require Key

class Dwarf extends Walker
  constructor:(game, level, i)->
    super(game, level, i)
    @num = i
    @carrying = null
    @signal = new Phaser.Signal()
    @chat_colour = ['#FF0000', '#FFFF88', '#8888FF', '#88FF88'][@num-1]
    @shadow_colour = ['#000000', '#000000', '#000000', '#000000'][@num-1]

  create_sprite:=>
    super
    gfx = "dwarf#{@player_number}"
    @sprite = @game.add.sprite(0, 0, gfx)
    @arrows = [
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow'),
      @game.add.sprite(0, 0, 'arrow')
    ]
    arrow.alpha = 0 for arrow in @arrows

  say:(message, callback=null)=>
    @chat_callback = callback
    @set_caption(message, 2, 20)
    timer = @game.time.create(false)
    timer.add(2500, @notify)
    timer.start()

  notify:=>
    @signal.dispatch()

  show_arrow:(dir, own)=>
    @arrows[dir].animations.frame = own*4 + dir
    @arrows[dir].alpha = 1

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
