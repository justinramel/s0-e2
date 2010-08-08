require 'rubygems'
require 'cinch'
require 'digest/md5'

irc = Cinch.setup :verbose => true do
  server "irc.freenode.org"
  nick "justin_bot"
end

irc.on("001") do |m|
	irc.join "#rmu-session-0", "zerowing"
end

irc.plugin "test :email" do |m|
	email_address = m.args[:email].downcase
	email_address["mailto:"]= ""

	hash = Digest::MD5.hexdigest(email_address)

	m.reply "http://www.gravatar.com/avatar/#{hash}"
end

irc.run
