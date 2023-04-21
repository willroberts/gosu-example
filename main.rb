#!/usr/bin/env ruby
# frozen_string_literal: true

require 'gosu'
require './character'
require './coin'

WINDOW_WIDTH = 320
WINDOW_HEIGHT = 240

# ZIndex is a convenience enum for Z-Order presets when drawing to the screen.
module ZIndex
  BACKGROUND, PICKUPS, CHARACTERS, HUD = *0..3
end

# GameWindow is the main game application.
class GameWindow < Gosu::Window
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT, fullscreen: false
    self.caption = 'Eggplant Game'

    @grass = Gosu::Image.new('images/grass.png', tileable: true)

    @character = Character.new
    @character.warp(
      WINDOW_WIDTH / 2 - 20,
      WINDOW_HEIGHT / 2 - 20
    )

    @coin_anim = Gosu::Image.load_tiles('images/coin.png', 25, 25)
    @coins = []

    @font = Gosu::Font.new(20)
  end

  # update() runs reliably at 60fps.
  def update
    handle_input

    # Collect coins when within range.
    @character.collect_coins(@coins)

    # Spawn more coins as needed.
    return unless (rand < 0.01) && (@coins.size < 3)

    @coins.push(Coin.new(@coin_anim))
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
    @coins.each(&:draw)

    # Player
    @character.draw

    # HUD
    @font.draw_text("Score: #{@character.coins}",
                    10, 10, ZIndex::HUD,
                    1.0, 1.0, Gosu::Color::WHITE)
  end

  def handle_input
    close if Gosu.button_down? Gosu::KB_ESCAPE
    @character.move_up if Gosu.button_down? Gosu::KB_UP
    @character.move_down if Gosu.button_down? Gosu::KB_DOWN
    @character.move_left if Gosu.button_down? Gosu::KB_LEFT
    return unless Gosu.button_down? Gosu::KB_RIGHT

    @character.move_right
  end
end

GameWindow.new.show
