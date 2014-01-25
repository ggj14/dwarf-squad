class Controller
  constructor:(player)->
    @player = player
    @ax = 0
    @ay = 0

  left:()=>
    @ax = -2000

  right:()=>
    @ax = 2000

  up:()=>
    @ay = -2000

  down:()=>
    @ay = 2000

  update:=>
    @player.accelerate(@ax, @ay)
    @ax = 0
    @ay = 0

root = exports ? window
root.Controller = Controller
