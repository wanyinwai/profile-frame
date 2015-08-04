Paperclip.interpolates :member_id do |attachment, style|
  attachment.instance.member_id # or whatever you've named your User's login/username/etc. attribute
end
