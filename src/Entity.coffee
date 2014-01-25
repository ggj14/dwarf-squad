class Entity
  constructor:(game, x, y)->
    @game = game
    @dead = false
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.x = x
    @sprite.y = y
    @sprite.body.height = 12
    @sprite.body.offset.y = 12

  destroy:=>
    return if @dead
    @sprite.destroy()
    @dead = true
    @onDestroy()

  onDestroy:=>
    #noop

  collide:(others)=>
    if others instanceof Array
      @collide_object(other) for other in others
    else
      @collide_object(others)

  collide_object:(other)=> 
    if other instanceof Entity
      @game.physics.collide(@sprite, other.sprite)
    else
      @game.physics.collide(@sprite, other)

  update:=>
    @onUpdate()

  onUpdate:=>
    #noop

  accelerate:(ax,ay)=>
    @sprite.body.acceleration.x = ax
    @sprite.body.acceleration.y = ay

root = exports ? window
root.Entity = Entity
