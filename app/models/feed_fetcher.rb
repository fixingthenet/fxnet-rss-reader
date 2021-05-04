class FeedFetcher

  attr_reader :logger
  attr_reader :raw_feed
  attr_reader :feed
  def initialize(feed, logger: Rails.logger, body: nil)
    @feed = feed
    @logger = logger
    @body = body
    @failed=0
    @stories=0
    @succeeded=0
  end

  def run
    fetch
    new_s = 0
    new_entries.each do |story|
      new_s += 1
      story.save!
    end
    feed.success!
    new_s
  end

  def fetch
      @body ||= open(@feed.url)
      #https://www.ruby-toolbox.com/projects/simple-rss
      @raw_feed = SimpleRSS.parse(@body)
      self
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

  def entries
    @entries ||= raw_feed.entries.map do |raw_entry|
      Story.new(
        title: CGI.unescapeHTML(raw_entry.title),
        permalink: raw_entry.link,
        entry_id: (raw_entry.guid || raw_entry.id),
        body: (raw_entry.description || raw_entry.summary),
        published: (raw_entry.pubDate || raw_entry.updated),
        feed: @feed
      )
    end
  end

  def modified?
    return true unless @feed.last_fetched_at

    time =  raw_feed.pubDate rescue raw_feed.updated
    time > @feed.last_fetched_at
  end

  def new_entries
    return [] unless modified?
    scraped_entry_ids=entries.map(&:entry_id)
    existing_entry_ids= Story.where(feed_id: @feed.id, entry_id: scraped_entry_ids).pluck("entry_id")
    entries.reject do |s| existing_entry_ids.include?(s.entry_id) end
  end

end
