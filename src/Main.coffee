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
    @game.stage.backgroundColor = '#000000'
    @game.stage.scale.pageAlignHorizontally = true;
    @game.stage.scale.refresh();
    message = "Loading..."
    style = {
      font: "20px Arial",
      fill: "#FFFFFF",
      align: "center"
    }
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, message, style)
    @text.anchor.setTo(0.5, 0.5);
    @game.load.image('logo', 'assets/logo.png')
    @game.load.image('labs', 'assets/labs.png')
    @game.load.spritesheet('dwarf1', 'assets/dwarf_01.png', 32, 32)
    @game.load.spritesheet('dwarf2', 'assets/dwarf_04.png', 32, 32)
    @game.load.spritesheet('dwarf3', 'assets/dwarf_03.png', 32, 32)
    @game.load.spritesheet('dwarf4', 'assets/dwarf_02.png', 32, 32)
    @game.load.spritesheet('skeleton', 'assets/skel.png', 32, 32)
    @game.load.spritesheet('sheep', 'assets/sheep.png', 32, 32)
    @game.load.spritesheet('arrow', 'assets/arrows.png', 16, 16)
    @game.load.spritesheet('objects', 'assets/objects.png', 32, 32)
    @game.load.image('key',   'assets/key.png')
    @game.load.spritesheet('world', 'assets/world.png', 32, 32)
    @game.load.image('boulder', 'assets/boulder.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level02', 'maps/level02.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level03', 'maps/level03.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('treasure_room', 'maps/treasure_room.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level_skeletons', 'maps/level_skeletons.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('intro', 'maps/intro.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.audio('splash', 'songs/DwarfMusic01.mp3');
    @game.load.audio('pain', 'sounds/pain.wav');
    @game.load.audio('crazy', 'sounds/CrazyTime.mp3');
    @game.load.audio('collect', 'sounds/Collect.mp3');
    @game.load.audio('baa1', 'sounds/SheepBaa1.mp3')
    @game.load.audio('baa2', 'sounds/SheepBaa2.mp3')
    @game.load.audio('baa3', 'sounds/SheepBaa3.mp3')
    @game.load.audio('button1', 'sounds/Button1.mp3');
    @game.load.audio('button2', 'sounds/Button2.mp3');
    @game.load.audio('bones', 'sounds/SkeletonBones.mp3')
    @game.load.audio('coin1', 'sounds/Coin1.mp3');
    @game.load.audio('coin2', 'sounds/Coin2.mp3');
    @game.load.audio('coin3', 'sounds/Coin3.mp3');
    @game.load.audio('coin4', 'sounds/Coin4.mp3');
    @game.load.audio('burp', 'sounds/Burp.mp3');
    @game.world.remove(@text)
    @text.destroy()

  create:()=>
    @music = @game.add.audio('splash');
    @music.play('', 0, 4, true)
    @game.physics.gravity.y = 0
    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    @scene_manager = new SceneManager()
    @scene_manager.add('splash', new Splash(@game, @scene_manager))
    @scene_manager.add('level', new Level(@game, @scene_manager))
    @scene_manager.init(@starting_scene)
    if @start_fullscreen
      @game.input.onDown.add(@gofull);

  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    @scene_manager.update()

root = exports ? window
root.Main = Main
