# frozen_string_literal: true

class Segment < ApplicationRecord
  has_many :models, foreign_key: 'model_segment', class_name: 'Model'
end
