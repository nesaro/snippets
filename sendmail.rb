#!/usr/bin/ruby

require 'net/smtp'

class SendMail < Net::SMTP

	def initialize(options)
		super
		@user     = options["user"]  
		@from     = options["from"] 
		@to       = options["to"].to_a 
		@pass     = options["pass"]  
		@server   = options["server"]
		@subject  = options["subject"]
	end
	def body=(mail_body)
		# BUILD HEADERS
		@body =  "From: #{@from} <#{@from}>\n" 
		@body << "To: #{@to}<#{@to}>\n"
		@body << "Subject: #{@subject}\n"
		@body << "Date: #{Time.now}\n"
		@body << "Importance:high\n"
		@body << "MIME-Version:1.0\n"
		@body << "\n\n\n"
		# MESSAGE BODY

		@body << mail_body

	end

	def send

		@to.each do | to |
			Net::SMTP.start(@server, 25 , @from , @user , @pass , :login)  do |smtp|
				smtp.send_message(@body,@from,to)
			end
		end

	end

end

if __FILE__ == $0

	print  %^USAGE:

	o=Hash.new    
	o["user"]    = "userid"
	o["from"]    = ""
	o["pass"]    = ""
	o["server"]  = "smtp server"
	o["subject"] = "TEST MESSAGE"
	mail=SendMail.new(o)
	mail.body="Hi buddy"
	mail.send
	^
end
