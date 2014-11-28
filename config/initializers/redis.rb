if Rails.env.test?
  Redis.current = Redis.new(db: 1)
end
