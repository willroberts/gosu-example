MOVE_DISTANCE = 6.0
PICKUP_DISTANCE = 20.0

class Character
  attr_reader :coins

  def initialize
    @image = Gosu::Image.new('images/eggplant.bmp')
    @x = 0.0
    @y = 0.0
    @sprite_size = 40.0
    @coins = 0
    # @coin_sound = Gosu::Sample.new("sounds/coin.wav")
  end

  ''' Pickups '''

  def collect_coins(coins)
    half_size = @sprite_size / 2.0
    coins.reject! do |coin|
      if Gosu.distance(@x + half_size, @y + half_size, coin.x, coin.y) < PICKUP_DISTANCE
        @coins += 1
        # @coin_sound.play
        true
      else
        false
      end
    end
  end

  ''' Movement '''

  def warp(x, y)
    @x = x
    @y = y
  end

  def move_up
    return if @y < MOVE_DISTANCE

    @y -= MOVE_DISTANCE
  end

  def move_down
    return if @y > WINDOW_HEIGHT - (@sprite_size + MOVE_DISTANCE)

    @y += MOVE_DISTANCE
  end

  def move_left
    return if @x < MOVE_DISTANCE

    @x -= MOVE_DISTANCE
  end

  def move_right
    return if @x > WINDOW_WIDTH - (@sprite_size + MOVE_DISTANCE)

    @x += MOVE_DISTANCE
  end

  ''' Rendering '''

  def draw
    @image.draw(@x, @y, ZIndex::CHARACTERS)
  end
end
