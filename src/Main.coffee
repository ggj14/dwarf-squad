#= require Level

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:(fullscreen)->
    super
    @launch_fullscreen = fullscreen

  preload:()=>
    @game.load.spritesheet('candy', 'assets/candy.png', 35, 35)
    @game.load.image('dungeon', 'assets/dungeon.png')
    @game.load.tilemap('level01', 'maps/level01.json', null, Phaser.Tilemap.TILED_JSON)
    @game.load.tilemap('level02', 'maps/level02.json', null, Phaser.Tilemap.TILED_JSON)

  create:()=>
    @game.stage.backgroundColor = '#FF00FF'
    @game.physics.gravity.y = 0
    @game.stage.fullScreenScaleMode = Phaser.StageScaleMode.SHOW_ALL;
    if @launch_fullscreen
      @game.input.onDown.add(@gofull);
    @pressed = false
    @level = new Level(@game)
    @level.init()
    @level.next()

  gofull:=>
    @game.stage.scale.startFullScreen();

  update:=>
    @level.update()
    if @game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
      @level.next() unless @pressed
      @pressed = true
    if !@game.input.keyboard.isDown(Phaser.Keyboard.SPACEBAR)
      @pressed = false

root = exports ? window
root.Main = Main
