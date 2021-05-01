class StoryResource < ApplicationResource
  attribute :title, :string
  attribute :permalink, :string
  attribute :body, :string
  attribute :entry_id, :string
  attribute :feed_id, :integer
  attribute :published,  :datetime
  attribute :created_at, :datetime
  attribute :updated_at, :datetime

  # user specific join on StoryOpen
  attribute :read_later_at, :datetime
  attribute :last_opened_at, :datetime
  attribute :story_open_id, :integer


  belongs_to :feed
  belongs_to :story_open

  def base_scope
    model.base(context.current_user)
  end

  filter :unread, :string do
    eq do |scope, value|
      scope.unread
    end
  end

  filter :bookmarked, :string do
    eq do |scope, value|
      scope.bookmarked
    end
  end
end
