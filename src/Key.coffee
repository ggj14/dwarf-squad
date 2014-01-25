#= require Entity
#= require Carryable

class Key extends Carryable
  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'key')

root = exports ? window
root.Key = Key