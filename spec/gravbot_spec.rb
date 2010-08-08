require 'grav_bot'

describe GravBot do
	before { @grav_bot = GravBot.new }

	describe ".clean_email, valid email" do
		before do
			@clean_email = @grav_bot.clean_email("justin.ramel@gmail.com")
		end

		it "should return email unchanged" do
			@clean_email.should == "justin.ramel@gmail.com"
		end
	end

	describe ".clean_email, email with mailto:" do
		before do
			@clean_email = @grav_bot.clean_email("justin.ramel@gmail.com")
		end

		it "should remove mailto:" do
			@clean_email.should == "justin.ramel@gmail.com"
		end
	end

	describe ".hash_email" do
		before { @hash = @grav_bot.hash_email("justin.ramel@gmail.com") }

		it "should return a valid hash" do
			@hash.should == "d969a33f2d9bf6e75ffcbdd9be99d6bd"
		end
	end

	describe ".send_reply" do
		before do
			@message = mock("message")	
			@message.should_receive(:reply).once.with("http://www.gravatar.com/avatar/myhash")	
		end

		it "should send reply which includes the hash" do
			@grav_bot.send_reply(@message, "myhash")
		end
		
	end
end
