class Image < ActiveRecord::Base
  belongs_to :category
  attr_accessible :image, :description

  has_attached_file :image, 
    :styles => { :image => "1024x768>", :thumb => "20x20#"}
end
