class Category < ActiveRecord::Base
  has_many :images
  attr_accessible :name
end
