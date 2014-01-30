class CreateIndividuals < ActiveRecord::Migration
  def self.up
    create_table :individuals do |t|
      t.string :client_number
      t.string :client_name
      t.string :tms
      t.string :spn
      t.string :ala
      t.string :ldc
      t.string :daos
      t.string :vas
      t.string :total
    end
  end
  def self.down
    drop_table :individuals
  end
end
