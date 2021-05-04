class FeedSubscriptionsController < ApiController
  RESOURCE=FeedSubscriptionResource
#  def index
#    feeds = FeedResource.all(params)
#    respond_with(feeds)
#  end

#  def show
#    feed = FeedResource.find(params)
#    respond_with(feed)
#  end

  def create
    res = RESOURCE.build(params)

    if res.save
      render jsonapi: res, status: 201
    else
      render jsonapi_errors: res
    end
  end

#  def update
#    feed = FeedResource.find(params)
#
#    if feed.update_attributes
#      render jsonapi: feed
#    else
#      render jsonapi_errors: feed
#    end
#  end

  def destroy
    res = RESOURCE.find(params)

    if res.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: res
    end
  end
end
