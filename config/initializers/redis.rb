REDIS = Redis.new(
  host: ENV.fetch("REDIS_HOST", "localhost"),
  port: ENV.fetch("REDIS_PORT", 6379),
  # password: ENV.fetch("REDIS_PASSWORD", nil),
  db: ENV.fetch("REDIS_DB", 0),
)
