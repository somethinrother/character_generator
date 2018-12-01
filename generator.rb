# frozen_string_literal: true

require 'json'
require 'facets'

# Picks a class for a player to play
class Generator
  attr_accessor :traits

  def initialize(traits)
    @traits = traits
    @playable_classes = playable_classes
  end

  def playable_classes
    possible_classes.each_with_object([]) do |class_data, playable_classes|
      class_name = class_data[0]
      matching_attributes = class_data[1]
      playable_classes << class_name if matching_attributes == 3
    end
  end

  private

  def class_json
    JSON.parse(File.read('classes.json'))
  end

  def class_names
    class_json.keys
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

  def possible_classes
    classes = {}

    class_json.each do |class_name, attributes|
      classes[class_name] = 0

      traits.each do |trait|
        classes[class_name] += 1 if attributes.include?(trait)
      end
    end
    classes.reject { |name| classes[name].zero? }
  end
end
