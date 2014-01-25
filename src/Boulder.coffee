class Boulder extends Actor
  constructor:(game, level)->
    super(game)
    @level = level

  create_sprite:=>
    @sprite = @game.add.sprite(0, 0, 'sheep')

  on_update:()=>
    @collide(@level.walkers)
    @collide(@level.walls)

root = exports ? window
root.Boulder = Boulder