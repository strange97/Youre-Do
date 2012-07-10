# == Schema Information
#
# Table name: messages
#
#  id                :integer         not null, primary key
#  sender_id         :integer
#  recipient_id      :integer
#  sender_deleted    :boolean         default(FALSE)
#  recipient_deleted :boolean         default(FALSE)
#  subject           :string(255)
#  body              :text
#  read_at           :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

class Message < ActiveRecord::Base

  is_private_message
  
  # The :to accessor is used by the scaffolding,
  # uncomment it if using it or you can remove it if not
  #attr_accessor :to
  
end
