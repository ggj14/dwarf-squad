class Controller
  constructor:(player)->
    @player = player
    @ax = 0
    @ay = 0

  left:()=>
    @ax = -1000

  right:()=>
    @ax = 1000

  up:()=>
    @ay = -1000

  down:()=>
    @ay = 1000

  update:=>
    @player.accelerate(@ax, @ay)
    @ax = 0
    @ay = 0

root = exports ? window
root.Controller = Controller
