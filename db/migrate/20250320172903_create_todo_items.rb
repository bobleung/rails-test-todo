class CreateTodoItems < ActiveRecord::Migration[8.0]
  def change
    create_table :todo_items do |t|
      t.string :name
      t.text :notes
      t.boolean :completed, default: false
      t.integer :order
      t.boolean :is_section, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :todo_items, :completed
    add_index :todo_items, :is_section
    add_index :todo_items, :order
  end
end
