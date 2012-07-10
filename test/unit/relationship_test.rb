# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
