#= require Walker

class Skeleton extends Walker

  create_sprite:=>
    super
    @sprite = @game.add.sprite(0, 0, 'skeleton')
    @quiet_time = 0

  set_animations: =>
    @anim_fps_x = 12
    @anim_fps_y = 6
    @min_anim_velocity = 25
    super

  set_physics: =>
    super
    @sprite.body.height = 16
    @sprite.body.width = 24
    @sprite.body.offset.x = 4
    @sprite.body.offset.y = 16
    @sprite.body.maxVelocity.x = 30
    @sprite.body.maxVelocity.y = 30

  on_update:=>
    # Walks to nearest player
    nearest = null
    nearest_dist = 9999
    for player in @level.players
      if !player.exited
        dist =  Math.abs(player.sprite.x - @sprite.x) +
                Math.abs(player.sprite.y - @sprite.y)
        if dist < nearest_dist
          nearest_dist = dist
          nearest = player


    if @quiet_time > 0.0
      @quiet_time -= @game.time.elapsed / 1000.0

    if nearest != null
      if @quiet_time <= 0.0 and Phaser.Math.chanceRoll(70)
        @quiet_time = 5.0 + Math.random() * 5.0
          
        @set_caption("Moooooaar!", 1.0, 20, 'bones')



    return unless nearest

    if nearest_dist < 400
      dx = nearest.sprite.x - @sprite.x
      dy = nearest.sprite.y - @sprite.y
      @accelerate(dx*5, dy*3)
    else
      @accelerate(0, 0)

root = exports ? window
root.Skeleton = Skeleton
