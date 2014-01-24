class Controller
  constructor:(player)->
    @player = player
    @ax = 0
    @ay = 0
    @dx = 0
    @dy = 0

  left:()=>
    @ax = -1

  right:()=>
    @ax = 1

  up:()=>
    @ay = -1

  down:()=>
    @ay = 1

  update:(dt)=>
    @dx += @ax*dt*0.1
    @dy += @ay*dt*0.1
    @player.move(@dx, @dy)
    @dx *= 0.8
    @dy *= 0.8
    @ax = 0
    @ay = 0

root = exports ? window
root.Controller = Controller
