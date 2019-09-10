class Task < ActiveRecord::Base
  belongs_to :list
  attr_accessible :complete, :name, :due_date

  validates :name, presence: true

  # scope :order_by_due_date, -> { self.sort_by {|task| task.due_date} }

  # scope :order_by_year, lambda {|task| order(year: :desc) }
  # #   { order(year: :desc) }
  # # end
  #
  # scope :by_name, lambda{ |name| where(name: name) unless name.nil? }

  def sort_due_date
    self.sort_by {|task| task.due_date}
  end

end
