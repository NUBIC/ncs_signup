class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :address
      t.string :apt_or_unit
      t.string :city
      t.string :state
      t.string :zip
      t.string :home_phone
      t.string :mobile_phone
      t.string :work_phone
      t.string :contact_preference
      t.string :email
      t.datetime :exported_at
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
