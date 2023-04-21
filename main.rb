#!/usr/bin/env ruby
require 'gosu'
require './character.rb'
require './coin.rb'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 240

module ZIndex
  BACKGROUND, PICKUPS, CHARACTERS, HUD = *0..3
end

class GameWindow < Gosu::Window
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT, :fullscreen => false
    self.caption = "Eggplant Game"

    @grass = Gosu::Image.new("images/grass.png", :tileable => true)

    @character = Character.new
    @character.warp(
      WINDOW_WIDTH / 2 - 20,
      WINDOW_HEIGHT / 2 - 20
    )

    @coin_anim = Gosu::Image.load_tiles("animations/coin.png", 25, 25)
    @coins = Array.new

    @font = Gosu::Font.new(20)
  end

  # update() runs reliably at 60fps.
  def update
    handle_input

    # Collect coins when within range.
    @character.collect_coins(@coins)

    # Spawn more coins as needed.
    if rand < 0.01 and @coins.size < 3
      @coins.push(Coin.new(@coin_anim))
    end
  end

  # draw() runs unreliably at 60fps.
  def draw
    # Background tiles
    0.step(WINDOW_WIDTH, 40).each do |x|
      0.step(WINDOW_HEIGHT, 40).each do |y|
        @grass.draw(x, y, ZIndex::BACKGROUND)
      end
    end

    # Pickups
    @coins.each { |coin| coin.draw }

    # Player
    @character.draw

    # HUD
    @font.draw_text("Score: #{@character.coins}",
                    10, 10, ZIndex::HUD,
                    1.0, 1.0, Gosu::Color::WHITE)
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
