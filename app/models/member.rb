class Member < ActiveRecord::Base
  # paperclip upload setting

	has_attached_file :profilepic,
	                :styles => { :medium => "300x300>", :thumb => "100x100>" },
									:storage => :s3,
									:default_url => "default.png",
									:path => "profilecustom/twenty3/:member_id.:extension",
									:bucket => ENV['AWS_BUCKET'],
									:s3_host_name => "s3-ap-southeast-1.amazonaws.com",
	                :s3_credentials => {
	                  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
	                  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
	            	  }


	validates_attachment  :profilepic,
	                    :content_type => { :content_type => ["image/jpeg", "image/jpg", "image/png"] },
	                    :size => { :in => 0..10.megabytes }

end
