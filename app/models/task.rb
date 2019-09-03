class Task < ActiveRecord::Base
  belongs_to :list
  attr_accessible :complete, :name, :due_date

  validates :name, presence: true
  validates :due_date, presence: true
end
