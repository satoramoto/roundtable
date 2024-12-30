class ChangeMessageContentType < ActiveRecord::Migration[8.0]
  def change
    change_column :messages, :content, :text
  end
end
