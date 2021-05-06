#!/code/bin/rails

Feed.unpaused.find_each do |feed|
  feed.delay.fetch
end
