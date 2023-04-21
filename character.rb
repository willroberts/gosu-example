MOVE_DISTANCE = 6.0
PICKUP_DISTANCE = 20.0

class Character
  attr_reader :coins

  def initialize
    @image = Gosu::Image.new("images/eggplant.bmp")
    @x = 0.0
    @y = 0.0
    @sprite_size = 40.0
    @coins = 0
  end

  ''' Pickups '''

  def coins
    @coins
  end

  def collect_coins(coins)
    half_size = @sprite_size / 2.0
    coins.reject! do |coin|
      if Gosu.distance(@x + half_size, @y + half_size, coin.x, coin.y) < PICKUP_DISTANCE
        @coins += 1
        true
      else
        false
      end
    end
  end

  ''' Movement '''

  def warp(x, y)
    @x, @y = x, y
  end

  def move_up
    if @y < MOVE_DISTANCE
      return
    end
    @y = @y - MOVE_DISTANCE
  end

  def move_down
    if @y > WINDOW_HEIGHT - (@sprite_size + MOVE_DISTANCE)
      return
    end
    @y = @y + MOVE_DISTANCE
  end

  def move_left
    if @x < MOVE_DISTANCE
      return
    end
    @x = @x - MOVE_DISTANCE
  end

  def move_right
    if @x > WINDOW_WIDTH - (@sprite_size + MOVE_DISTANCE)
      return
    end
    @x = @x + MOVE_DISTANCE
  end

  ''' Rendering '''

  def draw
    @image.draw(@x, @y, ZIndex::CHARACTERS)
  end
end
