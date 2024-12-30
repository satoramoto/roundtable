class AddFieldsToMessage < ActiveRecord::Migration[8.0]
  def change
    # Add 'content' and 'role' fields which are strings
    add_column :messages, :content, :string
    add_column :messages, :role, :string
  end
end
