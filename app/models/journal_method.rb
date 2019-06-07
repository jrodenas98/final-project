# == Schema Information
#
# Table name: journal_methods
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class JournalMethod < ApplicationRecord
    has_many :journal_prompts, :dependent => :destroy
end
