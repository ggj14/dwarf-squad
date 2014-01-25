#= require Entity

class Candy extends Entity
  constructor:(game, i)->
    @sprite = game.add.sprite(0, 0, 'candy')
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
