class Asset < ActiveRecord::Base
  attr_accessible :user_id, :uploaded_file
  
  belongs_to :user
  
  has_attached_file :uploaded_file,  
                :path => "assets/:id/:basename.:extension",  
                :storage => :s3,  
                :s3_credentials => "#{Rails.root}/config/amazon_s3.yml",  
                :bucket => "beherd_sharebox"
  
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes    
  validates_attachment_presence :uploaded_file
  
  def file_name  
      uploaded_file_file_name  
  end
  
  def file_size  
      uploaded_file_file_size  
  end
end
