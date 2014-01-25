#= require Entity

class Usable extends Entity
	constructor:(game, level, properties)->
		super(game, level, properties)

	move_to:(x, y, facing)=>
		if facing == Pad.RIGHT
			x += @sprite.width

		else if facing == Pad.LEFT
			x -= @sprite.width

		else if facing == Pad.DOWN
			y += @sprite.height/2

		else if facing == Pad.UP
			y -= @sprite.height/2

		@sprite.x = x
		@sprite.y = y


	drop:()=>
		console.log("drop")

	pickup:()=>
		console.log("pickup")

root = exports ? window
root.Usable = Usable