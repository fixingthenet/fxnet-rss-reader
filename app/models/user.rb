# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_one :open_id, class_name: 'Oidc::OpenId'
  has_many :feed_subscriptions, dependent: :destroy
end
