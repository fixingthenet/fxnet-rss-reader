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

  belongs_to :feed

  def base_scope
    model.base(current_user)
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

  def update(attributes)
    Rails.logger.warn(attributes)
    story = self.class.find(id: attributes.delete(:id)).data
    so=StoryOpen.story_of_user(story, current_user)

    if attributes.has_key?(:last_opened_at)
      story.last_opened_at=attributes[:last_opened_at]
      attributes.delete(:last_opened_at) ? so.open! : so.unopen!
    end

    if attributes.has_key?(:read_later_at)
      story.read_later_at=attributes[:read_later_at]
      attributes.delete(:read_later_at) ? so.read_later! : so.unread_later!
    end

    attributes.each_pair do |key, value|
      story.send(:"#{key}=", value)
    end

    story.save!
    story
  end

  private


end
