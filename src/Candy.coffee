#= require Entity

class Candy extends Entity
  constructor:(game, x, y, i)->
    @sprite = game.add.sprite x, y, 'candy'
    @sprite.animations.frame = i
    @sprite.body.friction = 2000
    @sprite.body.maxVelocity.x = 300
    @sprite.body.maxVelocity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.x = 0.4
    @sprite.body.bounce.y = 0.4
    super

root = exports ? window
root.Candy = Candy
