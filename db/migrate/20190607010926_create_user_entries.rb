class CreateUserEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :user_entries do |t|
      t.integer :user_id
      t.integer :prompt_id
      t.string :response
      t.text :headline

      t.timestamps
    end
  end
end
