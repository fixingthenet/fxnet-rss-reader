class FeedSubscriptionResource < ApplicationResource
  attribute :created_at, :datetime, only: [:readable]
  attribute :user_id, :integer, only: [:filterable]
  attribute :feed_id, :integer, only: [:writable,:filterable]

  belongs_to :feed

  after_attributes do |model|
    # After attributes have been assigned to the model
    model.user_id=current_user.id
  end

end
