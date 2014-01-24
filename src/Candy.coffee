#= require Entity

class Candy extends Entity
  constructor: (game, x, y, i)->
    @sprite = game.add.sprite x, y, 'candy'
    @sprite.animations.frame = i
    console.log(@sprite.body)
    @sprite.body.friction = 30
    @sprite.body.maxVelocity.x = 300
    @sprite.body.maxVelocity.y = 300
    super

root = exports ? window
root.Candy = Candy
