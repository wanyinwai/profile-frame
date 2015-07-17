class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :member_id
      t.string :email
      t.datetime :bday
      t.string :occupation

      t.timestamps null: false
    end
  end
end
