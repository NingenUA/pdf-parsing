class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :client
      t.string :bill
      t.string :user
      t.string :servpp
      t.string :ala
      t.string :ldarc
      t.string :dvao
      t.string :otherf
      t.string :gst
      t.string :subtotal
      t.string :total

    end
  end
  def self.down
    drop_table :groups
  end
end

