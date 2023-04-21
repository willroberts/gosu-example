class Coin
  attr_reader :x, :y

  def initialize(animation)
    @animation = animation
    @color = Gosu::Color::YELLOW.dup
    @x = rand * WINDOW_WIDTH
    @y = rand * WINDOW_HEIGHT
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
