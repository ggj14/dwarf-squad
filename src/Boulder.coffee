class Boulder extends Actor
  constructor:(game, level)->
    super(game)
    @level = level

  set_physics: =>
    super
    @sprite.body.width = 38
    @sprite.body.height = 25
    @sprite.body.offset.x = 5
    @sprite.body.offset.y = 20
    @sprite.body.maxVelocity.x = 30
    @sprite.body.maxVelocity.y = 30

  create_sprite:=>
    @sprite = @game.add.sprite(0, 0, 'boulder')

  on_update:()=>
    @collide(@level.walkers)
    @collide(@level.walls)
    @game.debug.renderSpriteBody(@sprite);

root = exports ? window
root.Boulder = Boulder