require 'rubygems'
require 'cinch'
require 'digest/md5'
require "#{File.dirname(__FILE__)}/bot_config"

class GravBot
	SERVER = "irc.freenode.org"
	CHANNEL = "#rmu-session-0"
	BOT_NAME = "grav_bot"

	def run
		setup	
		run
	end

	def setup
		@irc = Cinch.setup :verbose => true do
  		server SERVER 
  		nick BOT_NAME
		end

		@irc.on("001") do |m|
			@irc.join CHANNEL, PASSWORD 
		end

		@irc.plugin "#{BOT_NAME} :email" do |m|
			email = clean_email(m.args[:email])
			hash = hash_email(email)
			send_reply(m, hash)
		end
	end

	def clean_email(email)
		email.downcase.gsub("mailto:", "")
	end

	def hash_email(email)
		hash = Digest::MD5.hexdigest(email)
	end

	def send_reply(message, hash)
		message.reply "http://www.gravatar.com/avatar/#{hash}"
	end

	def run
		@irc.run
	end

end
