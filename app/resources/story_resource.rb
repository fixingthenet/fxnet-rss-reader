class StoryResource < ApplicationResource
  attribute :title, :string
  attribute :permalink, :string
  attribute :body, :string
  attribute :entry_id, :string
  attribute :feed_id, :integer
  attribute :published,  :datetime
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

  belongs_to :feed
  #belongs_to :user_story_open  # join to StoryOpen of the logged in user

  filter :unread, :string do
    eq do |scope, value|
      scope
    end
  end
  
  filter :bookmarked, :string do
    eq do |scope, value|
      scope
    end
  end
end
