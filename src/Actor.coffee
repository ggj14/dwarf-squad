#= require Entity

class Actor extends Entity
  constructor:(game)->
    super(game)
    @set_physics()

  set_physics: =>
    @sprite.body.friction = 2000
    @sprite.body.maxVelocity.x = 300
    @sprite.body.maxVelocity.y = 300
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.x = 0.4
    @sprite.body.bounce.y = 0.4
    @sprite.body.height = 16
    @sprite.body.width = 20
    @sprite.body.offset.x = 6
    @sprite.body.offset.y = 18

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



  collide:(others, callback = null, processor_fn = null)=>
    if others instanceof Array
      @collide_object(other, callback, processor_fn) for other in others
    else
      @collide_object(others, callback, processor_fn)

  collide_object:(other, callback, processor_fn)=>
    if other instanceof Entity
      return if other.sprite == @sprite
      # wrap a little function here so the callback gets the entity instead of the sprite
      @game.physics.collide(@sprite, other.sprite, (us, other_sprite)=>
        callback(@, other) if callback
      , (us, other_sprite)=>
        processor_fn(@, other) if processor_fn
      )
    else
      @game.physics.collide(@sprite, other, callback, processor_fn)

  update:=>
    @on_update()

  on_update:=>
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
root.Actor = Actor