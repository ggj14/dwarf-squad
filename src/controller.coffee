class Controller
  constructor: (player, game)->
    @player = player
    @game = game
    @up = null
    @down = null
    @left = null
    @right = null

  update: =>
    dx = 0
    dy = 0
    dx-=1 if @left()
    dx+=1 if @right()
    dy-=1 if @up()
    dy+=1 if @down()

    dx*=@game.time.elapsed*0.3;
    dy*=@game.time.elapsed*0.3;

    @player.move(dx, dy)
