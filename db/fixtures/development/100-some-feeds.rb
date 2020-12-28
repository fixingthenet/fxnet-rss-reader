Feed.seed(:name) do |s|
  s.name='Heise'
  s.url='https://www.heise.de/rss/heise-atom.xml'
  s.status=FeedStatus.green
  s.last_fetched_at=3.days.ago
end
