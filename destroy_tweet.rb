require "twitter"
require "csv"

@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "your_twitter_key"
  config.consumer_secret     = "your_twitter_secret_key"
  config.access_token        = "your_twitter_token"
  config.access_token_secret = "your_twitter_secret_token"
end

@not_deleted = []
@tweet_count = 0
@tweets = CSV.read('tweets.csv')

def error (tweet)
	puts "Tweet #{tweet} doesn't exist"
	@not_deleted.push(tweet)
end

def delete()
	
	@tweets.each do |tweet|

		begin
			@client.destroy_status(tweet)
			puts "Tweet #{tweet} destroyed."
			
		rescue	
			error(tweet)
		end
		@tweet_count += 1
		puts "#{@tweets.length - @tweet_count} Tweets left to review"
	end

	puts "List of Tweet that I could not delete: #{@not_deleted}"
end

delete