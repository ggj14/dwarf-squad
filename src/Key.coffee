#= require Entity
#= require Usable

class Key extends Usable
	constructor:(game, level, properties)->
		@sprite = game.add.sprite(0, 0, 'key')
		super(game, level, properties)

root = exports ? window
root.Key = Key