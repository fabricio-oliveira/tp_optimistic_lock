class CreateDummys < ActiveRecord::Migration
  def change
    create_table :dummys do |t|
      t.string :other
      t.string :uuid
      t.timestamps null: false
    end
    add_index :dummys, :uuid, unique: true
  end
end
