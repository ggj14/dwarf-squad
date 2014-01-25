class Entity
  constructor:(game)->
    @game = game
    @dead = false
    @create_sprite()
    alert "An entity didn't create its sprite in create_sprite()" unless @sprite

  create_sprite: =>
    # override

  destroy:=>
    return if @dead
    @sprite.destroy()
    @dead = true
    @onDestroy()

  add_to_group:(group)=>
    group.add(@sprite)
    @current_group = group
    @on_add_to_group(group) if @on_add_to_group

  onDestroy:=>
    #noop

  say:(dialogue)=>

root = exports ? window
root.Entity = Entity
