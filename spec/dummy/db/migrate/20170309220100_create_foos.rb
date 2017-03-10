class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :other
      t.string :uuid
      t.timestamps null: false
    end
    add_index :foos, :uuid, unique: true
  end
end
