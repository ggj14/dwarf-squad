#= require Candy
#= require Controller
#= require Pad

class Main extends Phaser.State
  # Weird bug with certain objects and particular versions of
  # coffeescript; without this call, instanceof checks fail
  constructor:()->
    super

  preload:()=>
    @game.load.spritesheet('candy', 'assets/candy.png', 35, 35)

  create:()=>
    @p1 = new Candy(@game, 250, 250, 1)
    @p2 = new Candy(@game, 500, 500, 2)
    @p3 = new Candy(@game, 250, 500, 3)
    @p4 = new Candy(@game, 500, 250, 4)

    @controller1 = new Controller(@p1, @game)
    @controller2 = new Controller(@p2, @game)
    @controller3 = new Controller(@p3, @game)
    @controller4 = new Controller(@p4, @game)

    @pad = new Pad(@game)
    @pad.on(0, Pad.UP, @controller1.up)
    @pad.on(0, Pad.DOWN, @controller1.down)
    @pad.on(0, Pad.LEFT, @controller1.left)
    @pad.on(0, Pad.RIGHT, @controller1.right)
    @pad.on(1, Pad.UP, @controller2.up)
    @pad.on(1, Pad.DOWN, @controller2.down)
    @pad.on(1, Pad.LEFT, @controller2.left)
    @pad.on(1, Pad.RIGHT, @controller2.right)
    @pad.on(2, Pad.UP, @controller3.up)
    @pad.on(2, Pad.DOWN, @controller3.down)
    @pad.on(2, Pad.LEFT, @controller3.left)
    @pad.on(2, Pad.RIGHT, @controller3.right)
    @pad.on(3, Pad.UP, @controller4.up)
    @pad.on(3, Pad.DOWN, @controller4.down)
    @pad.on(3, Pad.LEFT, @controller4.left)
    @pad.on(3, Pad.RIGHT, @controller4.right)

  update:()=>
    dt = @game.time.elapsed
    @pad.update(dt)
    @controller1.update(dt)
    @controller2.update(dt)
    @controller3.update(dt)
    @controller4.update(dt)

root = exports ? window
root.Main = Main
