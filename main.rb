#!/usr/bin/env ruby
require 'gosu'
require './character.rb'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 240

class GameWindow < Gosu::Window
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT, :fullscreen => false
    self.caption = "Example Game"

    @grass = Gosu::Image.new("grass.png", :tileable => true)

    @character = Character.new
    @character.warp(WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2)
  end

  # update() runs reliably at 60fps.
  def update
    handle_input
  end

  # draw() runs unreliably at 60fps.
  def draw
    0.step(WINDOW_WIDTH, 40).each do |x|
      0.step(WINDOW_HEIGHT, 40).each do |y|
        @grass.draw(x, y, 0)
      end
    end
    @character.draw
  end

  def handle_input
    if Gosu.button_down? Gosu::KB_ESCAPE
      close
    end
    if Gosu.button_down? Gosu::KB_UP
      @character.move_up
    end
    if Gosu.button_down? Gosu::KB_DOWN
      @character.move_down
    end
    if Gosu.button_down? Gosu::KB_LEFT
      @character.move_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      @character.move_right
    end
  end
end

GameWindow.new.show
