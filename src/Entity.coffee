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
    
    ##### Start of super dodgy hacks to swap out the position of the sprite for a rounded int version just in time for rendering but without affecting phyics
    @sprite.body.oldPostUpdate = @sprite.body.postUpdate
    @sprite.body.postUpdate = ->
      this.oldPostUpdate()
      this.sprite.float_x = this.sprite.x
      this.sprite.float_y = this.sprite.y
      this.sprite.x = parseInt(this.sprite.x)
      this.sprite.y = parseInt(this.sprite.y)
    @sprite.body.oldPreUpdate = @sprite.body.preUpdate
    @sprite.body.preUpdate = ->
      this.sprite.x = this.sprite.float_x if this.sprite.float_x
      this.sprite.y = this.sprite.float_y if this.sprite.float_y
      this.oldPreUpdate()
    ##### End of dat super dodgy hack

  destroy:=>
    return if @dead
    @sprite.destroy()
    @dead = true
    @onDestroy()

  onDestroy:=>
    #noop

  collide:(others, callback = null)=>
    if others instanceof Array
      @collide_object(other, callback) for other in others
    else
      @collide_object(others, callback)

  collide_object:(other, callback)=> 
    if other instanceof Entity
      return if other.sprite == @sprite
      @game.physics.collide(@sprite, other.sprite, callback)
    else
      @game.physics.collide(@sprite, other, callback)

  update:=>
    @onUpdate()

  onUpdate:=>
    #noop

  accelerate:(ax,ay)=>
    if ax > 1.0 || ax < -1.0
      @sprite.body.acceleration.x = ax
    else if @sprite.body.velocity.x != 0
      @sprite.body.acceleration.x = -(@sprite.body.velocity.x  * 15.0)

    if ay > 1.0 || ay < -1.0
      @sprite.body.acceleration.y = ay
    else if @sprite.body.velocity.y != 0
      @sprite.body.acceleration.y = -(@sprite.body.velocity.y  * 15.0)

root = exports ? window
root.Entity = Entity
