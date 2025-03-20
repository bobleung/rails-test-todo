class AddPositionToTodoItems < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_items, :position, :integer
    add_index :todo_items, :position
    
    reversible do |dir|
      dir.up do
        execute <<~SQL
          UPDATE todo_items
          SET position = CASE
            WHEN is_section THEN "order" * 1000
            ELSE "order" + (SELECT COALESCE(MAX("order"), 0) FROM todo_items AS s WHERE s.is_section = true AND s.id <= todo_items.id)
          END
        SQL
      end
    end
  end
end
