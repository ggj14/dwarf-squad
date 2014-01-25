class Trigger
  constructor:(game, level, properties)->
    @game = game
    @level = level
    @properties = properties
    @signal = new Phaser.Signal()
    @init()

  init:=>
    
  handle:=>
    @show_caption(@properties['caption']) if @properties['caption']
    @play_sound(@properties['sound']) if @properties['sound']
    @set_input(@properties['input']) if @properties['input']
    @play_dialogue(@properties['dialogue']) if @properties['dialogue']
    duration = +@properties['duration'] || 1000
    timer = @game.time.create(false)
    timer.add(duration, @finish)
    timer.start()

  set_input:(state)=>
    switch state
      when 'enable'
        @level.pad.enable()
      when 'disable'
        @level.pad.disable()

  show_caption:(caption)=>
    style = {
      font: "40px Arial",
      fill: "#FFFFFF",
      align: "center"
    }
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, caption, style)
    @text.anchor.setTo(0.5, 0.5);
  
  play_sound:(sound)=>  
    @game.add.sound(sound).play('', 0, 1)

  play_dialogue:(set)=>
    switch set
      when 'set1'
        @level.players[0].say("hello")
        @level.players[1].say("there")

  finish:=>
    if @text 
      @game.world.remove(@text)
      @text.destroy
    @signal.dispatch()

root = exports ? window
root.Trigger = Trigger