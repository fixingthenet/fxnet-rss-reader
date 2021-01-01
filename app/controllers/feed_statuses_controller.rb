class FeedStatusesController < ApplicationController
  def index
    feed_statuses = FeedStatusResource.all(params)
    respond_with(feed_statuses)
  end

  def show
    feed_status = FeedStatusResource.find(params)
    respond_with(feed_status)
  end

  def create
    feed_status = FeedStatusResource.build(params)

    if feed_status.save
      render jsonapi: feed_status, status: 201
    else
      render jsonapi_errors: feed_status
    end
  end

  def update
    feed_status = FeedStatusResource.find(params)

    if feed_status.update_attributes
      render jsonapi: feed_status
    else
      render jsonapi_errors: feed_status
    end
  end

  def destroy
    feed_status = FeedStatusResource.find(params)

    if feed_status.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: feed_status
    end
  end
end
