class CreateConversation < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.string :prompt

      t.timestamps
    end
  end
end
