class AddSectionReferenceToTodoItems < ActiveRecord::Migration[8.0]
  def change
    add_column :todo_items, :section_id, :integer, null: true
    add_index :todo_items, :section_id
  end
end
