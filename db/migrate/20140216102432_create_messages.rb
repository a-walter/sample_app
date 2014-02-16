class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end
    add_index :messages, [:from_id, :to_id]
  end
end
