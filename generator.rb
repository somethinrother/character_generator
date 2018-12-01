# frozen_string_literal: true

require 'json'
require 'facets'

# Picks a class for a player to play
class Generator
  attr_accessor :classes, :attributes, :class_data

  def initialize
    @classes = class_json.keys
    @attributes = find_attributes
    @class_data = class_json
  end

  def possible_classes(traits)
    classes = {}

    class_data.each do |class_name, attributes|
      classes[class_name] = 0

      traits.each do |trait|
        classes[class_name] += 1 if attributes.include?(trait)
      end
    end
    classes.reject { |name| classes[name].zero? }
  end

  private

  def class_json
    JSON.parse(File.read('classes.json'))
  end

  def find_attributes
    attributes = []
    class_json.each do |_class_name, attribute_list|
      attribute_list.each do |attribute|
        attributes << attribute unless attributes.include?(attribute)
      end
    end
    attributes
  end
end
