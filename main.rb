#!/usr/bin/env ruby
require 'gosu'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 240

class GameWindow < Gosu::Window
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT, :fullscreen => false
    self.caption = "Example Game"

    @eggplant = Gosu::Image.new("eggplant.png", :tileable => true)
  end

  # update() runs reliably at 60fps.
  def update
  end

  # draw() runs unreliably at 60fps.
  def draw
    0.step(WINDOW_WIDTH, 40).each do |x|
      0.step(WINDOW_HEIGHT, 40).each do |y|
        @eggplant.draw(x, y, 0)
      end
    end
  end
end

GameWindow.new.show
