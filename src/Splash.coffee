#= require Scene

class Splash extends Scene
  init:=>
    @zoom = 0.1
    @game.stage.backgroundColor = '#FFF'
    message = "Click To Play"
    style = {
      font: "20px Arial",
      fill: "#000000",
      align: "center"
    }
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, message, style)
    @text.anchor.setTo(0.5, 0.5);
    @game.input.onDown.addOnce(@startup);

  startup:=> 
    @faders = @game.add.group()
    @labs = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'labs')
    @labs.anchor.setTo(0.5, 0.5)
    @labs.scale.setTo(@zoom, @zoom)
    @labs.alpha = 0
    @faders.add(@labs)
    @game.add.tween(@text).to( { alpha: 0 }, 500, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(1000, @begin)
    timer.start()

  begin:=>
    @game.add.tween(@labs).to( { alpha: 1 }, 1000, Phaser.Easing.Linear.None, true);
    @game.add.tween(@labs.scale).to( { x: 2, y: 2 }, 4000, Phaser.Easing.Quadratic.None, true);
    timer = @game.time.create(false)
    timer.add(1000, @fadeout)
    timer.start()

  fadeout:=>
    @game.add.tween(@labs).to( { alpha: 0 }, 1000, Phaser.Easing.Linear.None, true);
    @finish()

  finish:=>
    @director.init('level')

root = exports ? window
root.Splash = Splash