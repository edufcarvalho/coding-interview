class TweetsController < ApplicationController
  def index
    limit = (params[:limit] || 10).to_i
    cursor = params[:cursor] # expects ISO8601 timestamp, e.g., "2024-05-20T12:00:00Z"

    tweets = if cursor
              Tweet.where('created_at < ?', Time.iso8601(cursor))
                    .order(created_at: :desc)
                    .limit(limit)
            else
              Tweet.order(created_at: :desc)
                    .limit(limit)
            end

    next_cursor = tweets.last&.created_at&.iso8601

    render json: {
      tweets: tweets,
      next_cursor: next_cursor
    }
  end
end
