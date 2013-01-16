class Todo < ActiveRecord::Base

  attr_accessible :completed, :position, :text

  validates :position, presence: true
  validates :text, presence: true
end
