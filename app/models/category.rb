class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :todos, :through => :categorizations
end
