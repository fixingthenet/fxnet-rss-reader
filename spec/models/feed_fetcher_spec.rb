require 'rails_helper'

RSpec.describe FeedFetcher do
  let(:feed) do
    Feed.create!(url: "http://example.com", name: "test", status: FeedStatus.green)
  end
  let(:feed_body) do
    File.read("#{__dir__}/../fixtures/rss.rdf")
  end

  it "should parse it" do
    f=FeedFetcher.new(feed, body: feed_body)
    f.fetch
    expect(f.raw_feed).to be_nil
  end

  it "should detect modification" do
    byebug
    f=FeedFetcher.new(feed, body: feed_body)

    f.fetch

    byebug
    expect(f).to be_modified
  end
 it "should extract new ones"
 it "should insert the new ones"

end
