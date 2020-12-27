class FeedFetcher

  attr_reader :logger
  attr_reader :raw_feed

  def initialize(feed, logger: Rails.logger, body: nil)
    @feed = feed
    @logger = logger
    @body = body
    @failed=0
    @stories=0
    @succeeded=0
  end

  def fetch
      @body ||= open(@feed.url)
      #https://www.ruby-toolbox.com/projects/simple-rss
      @raw_feed = SimpleRSS.parse(@body)
  end

  def parse
    new_entries_from(raw_feed).each do |entry|
      @stories += 1
      if Story.create_from_raw(@feed,entry)
        @succeeded += 1
      else
        @failed += 1
      end
    end
    @feed.last_modified!(raw_feed.last_modified)

    @feed.status!(:green)
  end

  def modified?
    raw_feed.last_modified && raw_feed.last_modified > @feed.last_fetched_at
  end

  def new_entries
    finder = NewStoriesFinder.new(raw_feed, @feed.last_fetched_at, @feed.latest_entry_id)
    finder.new_stories
  end


end
