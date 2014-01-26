#= require Pad

class Controller
  constructor:(player)->
    @player = player
    @ax = 0
    @ay = 0

  left:(pid)=>
    @ax = -2000
    @player.show_arrow(Pad.LEFT, pid)

  right:(pid)=>
    @ax = 2000
    @player.show_arrow(Pad.RIGHT, pid)

  up:(pid)=>
    @ay = -2000
    @player.show_arrow(Pad.UP, pid)

  down:(pid)=>
    @ay = 2000
    @player.show_arrow(Pad.DOWN, pid)

  update:=>
    @player.accelerate(@ax, @ay)
    @ax = 0
    @ay = 0

root = exports ? window
root.Controller = Controller
