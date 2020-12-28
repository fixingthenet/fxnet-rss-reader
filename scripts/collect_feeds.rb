#!/code/bin/rails

Feed.find_each do |feed|
  feed.delay.fetch
end
  