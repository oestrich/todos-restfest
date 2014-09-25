class Todo < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations

  def self.incomplete
    where(:completed_on => nil)
  end

  def self.complete
    where("completed_on IS NOT NULL")
  end

  def complete!
    update(:completed_on => Date.today)
  end

  def incomplete!
    update(:completed_on => nil)
  end

  def completed?
    completed_on.present?
  end
end
