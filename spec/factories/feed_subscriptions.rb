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
FactoryBot.define do
  factory :feed_subscription do
    
  end
end
