# == Schema Information
#
# Table name: user_entries
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  prompt_id         :integer
#  response          :string
#  headline          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  journal_method_id :integer
#

class UserEntry < ApplicationRecord
    
    belongs_to :user
    belongs_to :prompt, :class_name => "JournalPrompt"
    
end
