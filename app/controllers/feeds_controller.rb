class FeedsController < ApplicationController
  def index
    feeds = FeedResource.all(params)
    respond_with(feeds)
  end

  def show
    feed = FeedResource.find(params)
    respond_with(feed)
  end

  def create
    feed = FeedResource.build(params)

    if feed.save
      render jsonapi: feed, status: 201
    else
      render jsonapi_errors: feed
    end
  end

  def update
    feed = FeedResource.find(params)

    if feed.update_attributes
      render jsonapi: feed
    else
      render jsonapi_errors: feed
    end
  end

  def destroy
    feed = FeedResource.find(params)

    if feed.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: feed
    end
  end
end
