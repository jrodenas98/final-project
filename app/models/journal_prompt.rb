# == Schema Information
#
# Table name: journal_prompts
#
#  id                :integer          not null, primary key
#  prompt_text       :text
#  day               :string
#  journal_method_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class JournalPrompt < ApplicationRecord
    has_many :user_entries, :foreign_key => "prompt_id", :dependent => :destroy
    belongs_to :journal_method
 
end
