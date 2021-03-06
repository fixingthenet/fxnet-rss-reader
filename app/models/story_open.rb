# == Schema Information
#
# Table name: user_opens
#
#  id             :integer          not null, primary key
#  last_opened_at :datetime
#  user_id        :integer          not null
#  story_id       :integer          not null
#  read_later_at  :datetime
#

class StoryOpen < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  def self.story_of_user(story, user)
    where(["story_id=? AND user_id=?", story.id, user.id]).first || new(:story => story, :user => user)
  end

  def open!
    update!(:last_opened_at => Time.now)
    self
  end

  def unopen!
    update!(:last_opened_at => nil)
    self
  end

  def toggle_open!
    opened? ? unopen! : open!
  end

  def opened?
    !!last_opened_at
  end


  scope :for_stories, lambda { |stories, user|
    where(:user_id => user.id).where(['story_id in (?)', stories.map(&:id)])
  }

  def self.missing(story, user)
    new(:story => story, :user => user)
  end

  def read_later!
    update!(:read_later_at => Time.now)
    self
  end

  def unread_later!
    update!(:read_later_at => nil)
    self
  end

  def toggle_read_later!
    read_later? ? unread_later! : read_later!
  end

  def read_later?
    !!read_later_at
  end

  private


end
