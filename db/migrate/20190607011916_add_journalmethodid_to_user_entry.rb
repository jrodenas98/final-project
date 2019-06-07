class AddJournalmethodidToUserEntry < ActiveRecord::Migration[5.1]
  def change
    add_column :user_entries, :journal_method_id, :integer
  end
end
