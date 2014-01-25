#= require SceneManager
#= require Level
#= require Splash

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:(fullscreen, scene)->
    super
    @launch_fullscreen = fullscreen
    @starting_scene = scene

  preload:()=>
    @game.load.image('logo', 'assets/logo.png')
    @game.load.image('labs', 'assets/labs.png')
    @game.load.spritesheet('candy', 'assets/candy.png', 35, 35)
    @game.load.image('world', 'assets/world.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level02', 'maps/level02.json', null, Phaser.Tilemap.TILED_JSON)

  create:()=>
    @game.stage.backgroundColor = '#FF00FF'
    @game.physics.gravity.y = 0
    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    if @launch_fullscreen
      @game.input.onDown.add(@gofull);
    @scene_manager = new SceneManager()
    @scene_manager.add('splash', new Splash(@game, @scene_manager))
    @scene_manager.add('level', new Level(@game, @scene_manager))
    @scene_manager.init(@starting_scene)

  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    @scene_manager.update()

root = exports ? window
root.Main = Main
