class StoryResource < ApplicationResource
  attribute :title, :string, only: [:readable]
  attribute :permalink, :string, only: [:readable]
  attribute :body, :string, only: [:readable]
  attribute :entry_id, :string, only: [:readable]
  attribute :feed_id, :integer, only: [:readable]
  attribute :published,  :datetime, only: [:readable]
  attribute :created_at, :datetime, only: [:readable]
  attribute :updated_at, :datetime, only: [:readable]

  # user specific join on StoryOpen
  attribute :read_later_at, :datetime, only: [:readable, :writable]
  attribute :last_opened_at, :datetime, only: [:readable, :writable]

  belongs_to :feed

  def base_scope
    model.base(current_user)
  end

  filter :unread, :string, single: true, only: [:eq] do
    eq do |scope, value|
      scope.unread
    end
  end

  filter :bookmarked, :string, single: true, only: [:eq] do
    eq do |scope, value|
      logger.debug("StoryResource bookmarked #{value.inspect}")
      if value=="true"
        scope.bookmarked
      else
        scope.unbookmarked
      end
    end
  end

  def update(attributes)
    logger.debug("StoryResource update #{attributes}")
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
