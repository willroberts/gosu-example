class Character
  def initialize
    @image = Gosu::Image.new("eggplant.bmp")
    @x = 0.0
    @y = 0.0
    @sprite_size = 40.0
    @move_distance = 10.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_up
    if @y < @move_distance
      return
    end
    @y = @y - @move_distance
  end

  def move_down
    if @y > WINDOW_HEIGHT - (@sprite_size + @move_distance)
      return
    end
    @y = @y + @move_distance
  end

  def move_left
    if @x < @move_distance
      return
    end
    @x = @x - @move_distance
  end

  def move_right
    if @x > WINDOW_WIDTH - (@sprite_size + @move_distance)
      return
    end
    @x = @x + @move_distance
  end

  def draw
    @image.draw(@x, @y, 1)
  end
end
