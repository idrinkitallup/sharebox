class Folder < ActiveRecord::Base
  
  acts_as_tree 
  
  belongs_to :user
  
  has_many :assets, :dependent => :destroy
  
  attr_accessible :name, :parent_id, :user_id
end
