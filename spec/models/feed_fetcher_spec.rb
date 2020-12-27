require 'rails_helper'

RSpec.describe FeedFetcher do
  let(:feed) do
    Feed.create!(url: "http://example.com",
                 name: "test",
                 status: FeedStatus.green,
                 last_fetched_at: Time.now)
  end


  let(:feed_body) do
#    File.read("#{__dir__}/../fixtures/rss.rdf")
    File.read("#{__dir__}/../fixtures/rss-atom.xml")
  end
  let (:f) {
    FeedFetcher.new(feed, body: feed_body).fetch
  }

  it "should parse it" do
    expect(f.raw_feed).not_to be_nil
  end

  it "should detect modification" do
    expect(f).not_to be_modified
  end
  it "should extract all as stories" do
    expect(f.entries.size).to eq(166)
  end
  describe "finding new ones" do
    it "should be no new ones when pubdate is old" do
      expect(f.new_entries.size).to eq(0)
    end
    it "should find all when no Stories saved" do
      allow(f).to receive(:modified?).and_return(true)
      expect(f.new_entries.size).to eq(166)
    end
    it "should find only the unknown" do
      allow(f).to receive(:modified?).and_return(true)
      f.entries.first.save!
      f.entries.last.save!
      expect(f.new_entries.size).to eq(164)
    end
  end
end
