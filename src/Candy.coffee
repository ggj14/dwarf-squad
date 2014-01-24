class Candy extends Entity

 constructor: (game, x, y, i)->
    @sprite = game.add.sprite x, y, 'candy'
    @sprite.animations.frame = i
    super



