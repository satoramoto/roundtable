class CreateMessage < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.text :message

      t.timestamps
    end
  end
end
