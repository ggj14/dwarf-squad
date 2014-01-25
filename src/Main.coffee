#= require SceneManager
#= require Level
#= require Splash

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:(fullscreen, scene)->
    super
    @starting_scene = scene
    @start_fullscreen = fullscreen

  preload:()=>
    @game.load.image('logo', 'assets/logo.png')
    @game.load.image('labs', 'assets/labs.png')
    @game.load.spritesheet('dwarf1', 'assets/dwarf_01.png', 32, 32)
    @game.load.spritesheet('dwarf2', 'assets/dwarf_04.png', 32, 32)
    @game.load.spritesheet('dwarf3', 'assets/dwarf_03.png', 32, 32)
    @game.load.spritesheet('dwarf4', 'assets/dwarf_02.png', 32, 32)
    @game.load.spritesheet('arrow', 'assets/arrows.png', 16, 16)
    @game.load.image('key',   'assets/key.png')
    @game.load.image('world', 'assets/world.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level02', 'maps/level02.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.audio('splash', 'songs/DwarfMusic01.mp3');
    @game.load.audio('pain', 'sounds/pain.wav');
    @game.load.audio('crazy', 'sounds/CrazyTime.mp3');
    @game.load.audio('collect', 'sounds/Collect.mp3');

  create:()=>
    @game.stage.backgroundColor = '#FF00FF'
    @game.physics.gravity.y = 0
    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    @scene_manager = new SceneManager()
    @scene_manager.add('splash', new Splash(@game, @scene_manager))
    @scene_manager.add('level', new Level(@game, @scene_manager))
    @scene_manager.init(@starting_scene)
    if @start_fullscreen
      @game.input.onDown.add(@gofull);

    swapAxis = @game.input.keyboard.addKey(Phaser.Keyboard.ONE)
    swapAxis.onUp.add(@process_jumble)

    swapDir = @game.input.keyboard.addKey(Phaser.Keyboard.TWO)
    swapDir.onUp.add(@process_changeup)

    flushChanges = @game.input.keyboard.addKey(Phaser.Keyboard.THREE)
    flushChanges.onUp.add(@process_flush_changes)


  processNext:(event)=>
    @level.next()

  process_jumble:(event)=>
    Controller.flip_axis(@scene_manager.get_current())

  process_changeup:(event)=>
    Controller.flip_direction(@scene_manager.get_current())
  
  process_flush_changes:(event)=>
    Controller.flush_directions(@scene_manager.get_current())


  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    @scene_manager.update()

root = exports ? window
root.Main = Main
