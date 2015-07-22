class AddAttachmentProfilepicToMembers < ActiveRecord::Migration
  def self.up
    change_table :members do |t|
      t.attachment :profilepic
    end
  end

  def self.down
    remove_attachment :members, :profilepic
  end
end
