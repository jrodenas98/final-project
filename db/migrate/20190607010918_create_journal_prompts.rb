class CreateJournalPrompts < ActiveRecord::Migration[5.1]
  def change
    create_table :journal_prompts do |t|
      t.text :prompt_text
      t.string :day
      t.integer :journal_method_id

      t.timestamps
    end
  end
end
