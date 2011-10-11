class Idea < ActiveRecord::Base
  validates_presence_of :notes
  validates_length_of :notes, :in => 10..160
end