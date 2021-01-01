# == Schema Information
#
# Table name: feed_subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  feed_id    :bigint
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe FeedSubscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
