class StoriesController < ApplicationController
  def index
    stories = StoryResource.all(params)
    respond_with(stories)
  end

  def show
    story = StoryResource.find(params)
    respond_with(story)
  end

  def create
    story = StoryResource.build(params)

    if story.save
      render jsonapi: story, status: 201
    else
      render jsonapi_errors: story
    end
  end

  def update
    story = StoryResource.find(params)

    if story.update_attributes
      render jsonapi: story
    else
      render jsonapi_errors: story
    end
  end

  def destroy
    story = StoryResource.find(params)

    if story.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: story
    end
  end
end
