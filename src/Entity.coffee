class Entity

  constructor: (game, x, y)->
    @game = game
    @dead = false
    @sprite.anchor.x = 0.5
    @sprite.anchor.y = 0.5
    @sprite.x = x
    @sprite.y = y

  destroy: =>
    return if @dead
    @sprite.destroy()
    @dead = true
    @onDestroy()

  onDestroy: =>
    #noop

  update: =>
    @onUpdate()

  onUpdate: =>
    #noop

  move: (dx,dy)=>
    @sprite.x += dx
    @sprite.y += dy

root = exports ? window
root.Entity = Entity
