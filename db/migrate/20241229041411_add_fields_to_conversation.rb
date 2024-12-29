class AddFieldsToConversation < ActiveRecord::Migration[8.0]
  def change
    add_column :conversations, :persona1, :string
    add_column :conversations, :persona2, :string
    add_column :conversations, :persona3, :string

    add_column :conversations, :prompt, :string
  end
end
