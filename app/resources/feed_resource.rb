class FeedResource < ApplicationResource
  attribute :name, :string
  attribute :url, :string
  attribute :feed_status_id, :integer

  attribute :last_fetched_at, :datetime, only: [:readable]
  attribute :created_at, :datetime, only: [:readable]
  attribute :updated_at, :datetime, only: [:readable]
  attribute :last_success_at, :datetime, only: [:readable]
  attribute :last_success_count, :integer, only: [:readable]
  attribute :last_failed_count, :integer, only: [:readable]
  attribute :last_failed_at, :datetime, only: [:readable]
  attribute :feed_subscriptions_count, :integer, only: [:readable]

  belongs_to :feed_status

  has_one :user_subscription, resource: FeedSubscriptionResource do
    params do |hash, feeds|
      hash[:filter][:user_id] = Graphiti.context[:object].current_user.id
    end
  end

  before_save do |obj|
    obj.status ||= FeedStatus.yellow
  end
end
