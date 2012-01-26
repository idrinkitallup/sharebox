ActionMailer::Base.smtp_settings = {  
 :address              => "smtp.gmail.com",  
 :port                 => 25,  
 :domain               => "gmail.com",  
 :user_name            => "cloudshare.nz",  
 :password             => "cloudsharemailer",  
 :authentication       => :login,  
 :enable_starttls_auto => true  
}