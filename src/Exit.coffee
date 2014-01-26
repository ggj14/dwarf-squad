#= require Entity

class Exit extends Actor
  constructor:(game, level, properties)->
    super(game)
    @level = level
    @properties = properties
    @count = 0
    @collect_sound = @game.add.sound("collect")

    # default to letting dwarves in
    @properties.accepts ||= "Dwarf"

  create_sprite: =>
    @sprite = @game.add.sprite(0, 0, 'objects')
    @sprite.animations.frame = 8

  set_physics: =>
    super
    @sprite.body.immovable = true

    # whole tile collision
    @sprite.body.height = 32
    @sprite.body.width = 32
    @sprite.body.offset.x = 0
    @sprite.body.offset.y = 0

  on_update:()=>
    if @level.pad.enabled
      @collide(@level.walkers, @walker_entered)

  walker_entered:(door, walker)=>
    return if walker.exited

    if @properties['accepts'] == walker.constructor.name
      if @properties.relocates != undefined && @properties.relocates
        console.log "relocates"
        walker.sprite.x = @sprite.x
        walker.sprite.y = @sprite.y - 50
      else
        walker.remove_from_group(@level.entities)
        walker.ignore = true

      walker.exited = true
      @count += 1
      @collect_sound.play('', 0, 1)
      if @count == +@properties['count']
        @level.signals[@properties['id']].dispatch()

root = exports ? window
root.Exit = Exit
