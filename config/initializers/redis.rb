if Rails.env.test?
  Redis.current = Redis.new(db: 1)
end

if ENV["REDISCLOUD_URL"]
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end
