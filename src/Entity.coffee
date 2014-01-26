class Entity
  constructor:(game)->
    @game = game
    @dead = false
    @create_sprite()
#   alert "An entity didn't create its sprite in create_sprite()" unless @sprite
    @solid = true

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

  remove_from_group:(group)=>
    group.remove(@sprite)
    @current_group = null
    @on_remove_from_group(group) if @on_remove_from_group


  onDestroy:=>
    #noop

  say:(dialogue)=>

root = exports ? window
root.Entity = Entity
