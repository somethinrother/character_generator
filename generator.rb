# frozen_string_literal: true

require 'json'

# Picks a class for a player to play
class Generator
  attr_accessor :class_json

  def initialize
    file = File.read('classes.json')
    @class_json = JSON.parse(file)
  end
end
