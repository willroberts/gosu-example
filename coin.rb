# frozen_string_literal: true

class Coin
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::YELLOW.dup
    @sprite_size = 25
    @x = rand * WINDOW_WIDTH
    @y = rand * WINDOW_HEIGHT

    # Prevent spawning actors out-of-bounds.
    half_size = @sprite_size / 2.0
    if @x > WINDOW_WIDTH - half_size
      @x = WINDOW_WIDTH - half_size
    elsif @x < half_size
      @x = half_size
    end
    if @y > WINDOW_HEIGHT - half_size
      @y = WINDOW_HEIGHT - half_size
    elsif @y < half_size
      @y = half_size
    end
  end

  def draw
    img = @animation[Gosu.milliseconds / 100 % @animation.size]
    img.draw(
      @x - img.width / 2.0,
      @y - img.height / 2.0,
      ZIndex::PICKUPS, 1, 1, @color, :add
    )
  end
end
