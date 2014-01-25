#= require Scene

class Splash extends Scene
  init:->
    @zoom = 0.1
    @game.stage.backgroundColor = '#FFF'
    message = "do something to begin"
    style = {
      font: "65px Arial",
      fill: "#ff0044",
      align: "center"
    }
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, message, style)
    @text.anchor.setTo(0.5, 0.5);
    @game.input.onDown.addOnce(@startup);

  startup:=> 
    @music = @game.add.audio('splash');
    @music.play('', 0, 4, true)
    console.log(@music)
    @labs = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'labs')
    @labs.anchor.setTo(0.5, 0.5)
    @labs.scale.setTo(@zoom, @zoom)
    @labs.alpha = 0
    @game.add.tween(@text).to( { alpha: 0 }, 500, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(500, @begin)
    timer.start()

  begin:=>
    @game.add.tween(@labs).to( { alpha: 1 }, 2000, Phaser.Easing.Linear.None, true);
    @game.add.tween(@labs.scale).to( { x: 1, y: 1 }, 8000, Phaser.Easing.Quadratic.None, true);
    timer = @game.time.create(false)
    timer.add(3000, @fadeout)
    timer.start()

  fadeout:=>
    @game.add.tween(@labs).to( { alpha: 0 }, 2000, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(2000, @finish)
    timer.start()

  finish:=>
    #@music.stop()
    @director.init('level')

root = exports ? window
root.Splash = Splash