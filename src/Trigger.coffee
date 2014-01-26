class Trigger
  constructor:(game, level, properties)->
    @game = game
    @level = level
    @properties = properties
    @signal = new Phaser.Signal()
    @init()

  init:=>

  handle:=>
    notify = true
    if @properties['caption']
      notify = false
      @show_caption(@properties['caption'])
    if @properties['hint']
      notify = false
      @show_hint(@properties['hint'])
    if @properties['sound']
      @play_sound(@properties['sound'])
    if @properties['input']
      @set_input(@properties['input'])
    if @properties['dialogue']
      notify = false
      @play_dialogue(@properties['dialogue'])
    @finish() if notify   

  set_input:(state)=>
    switch state
      when 'enable'
        @level.pad.enable()
      when 'disable'
        @level.pad.disable()
      when '0' 
        @level.pad.enable_player(0) 
      when '1' 
        @level.pad.enable_player(1) 
      when '2' 
        @level.pad.enable_player(2) 
      when '3' 
        @level.pad.enable_player(3) 

  show_caption:(caption)=>
    style = {
      font: "40px Arial",
      fill: "#FFFFFF",
      align: "center"
    }
    shadow = {
      font: "40px Arial",
      fill: "#000000",
      align: "center"
    }
    @shadow = @game.add.text(@game.world.centerX+4, @game.world.centerY+4, caption, shadow)
    @shadow.anchor.setTo(0.5, 0.5);
    @shadow.alpha = 0
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, caption, style)
    @text.anchor.setTo(0.5, 0.5);
    @text.alpha = 0
    console.log(@text)
    @fade_in()

  show_hint:(caption)=>
    style = {
      font: "18px Arial",
      fill: "#FFFF00",
      align: "center"
    }
    shadow = {
      font: "18px Arial",
      fill: "#000000",
      align: "center"
    }
    @shadow = @game.add.text(@game.world.centerX+2, @game.world.centerY+2, caption, shadow)
    @shadow.anchor.setTo(0.5, 0.5);
    @shadow.alpha = 0
    @text = @game.add.text(@game.world.centerX, @game.world.centerY, caption, style)
    @text.anchor.setTo(0.5, 0.5);
    @text.alpha = 0
    @fade_in()

  fade_in:=>
    @game.add.tween(@text).to( { alpha: 1 }, 500, Phaser.Easing.Linear.None, true);
    @game.add.tween(@shadow).to( { alpha: 1 }, 500, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(2000, @fade_out)
    timer.start()
    
  fade_out:=>
    @game.add.tween(@text).to( { alpha: 0 }, 500, Phaser.Easing.Linear.None, true);
    @game.add.tween(@shadow).to( { alpha: 0 }, 500, Phaser.Easing.Linear.None, true);
    timer = @game.time.create(false)
    timer.add(1000, @finish)
    timer.start()

  play_sound:(sound)=>
    @game.add.sound(sound).play('', 0, 1)

  play_dialogue:(set)=>
    switch set
      when 'intro1'
        @level.players[0].signal.addOnce(@finish)
        @level.players[0].say("So, that's the plan. Right. I'm off to bed.")
      when 'intro2'
        @level.players[1].signal.addOnce(@finish)
        @level.players[1].say("Looks like he's had too much grog. My turn.")
      when 'intro3'
        @level.players[2].signal.addOnce(@finish)
        @level.players[2].say("OK Nigel, see you tomorrow. Sweet dreams.")
      when 'intro4'
        @level.players[3].signal.addOnce(@finish)
        @level.players[3].say("*burp*")
      when 'set1'
        @level.players[0].signal.addOnce(@finish)
        @level.players[0].say("Hi, mum!")
      when 'treasure'
        @level.players[3].signal.addOnce(@finish)
        @level.players[0].say "Dwarves", =>
          @level.players[1].say "Fucking", =>
            @level.players[2].say "LOVE", =>
              @level.players[3].say "TREASURE!!!!", =>
                @level.players[0].say "CHAAARRRGE!!"
                @level.players[1].say "CHAAARRRGE!!"
                @level.players[2].say "CHAAARRRGE!!"
                @level.players[3].say "CHAAARRRGE!!"


  finish:=>
    if @text
      @text.destroy()
      @shadow.destroy()
    @signal.dispatch()

root = exports ? window
root.Trigger = Trigger
