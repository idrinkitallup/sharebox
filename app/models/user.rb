class User < ActiveRecord::Base
  
  has_many :folders
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  
  validates :email, :presence => true, :uniqueness => true
  
  has_many :assets
end
