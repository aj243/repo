class Resume
	attr_accessor :name, :email, :phone_no, :skill, :interest
	class << self

		def build
			user_info = new
			user_info.intialize_name
			user_info.intialize_email
			user_info.intialize_phone_no
			user_info.intialize_skill
			user_info.intialize_interest
			user_info.check_file
		end

	end

	def intialize_name
		puts "Enter Name: "
		self.name = gets.strip
		if name.match(/^[a-z ,.'-]+$/i)
		else
			puts "Name entered is not valid"
			intialize_name
		end
	end

	def intialize_email
		puts "Enter Email: "
		self.email = gets.strip
		if email.match('^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$')
		else
			puts "Email is not valid"
			intialize_email
		end
	end

	def intialize_phone_no
		puts "Enter Phone No.: "
		self.phone_no = gets.strip.delete(' ')
		if phone_no.match('^[0-9]{10,11}')
		else
			puts "Phone No. not valid"
			intialize_phone_no
		end
	end

	def intialize_skill
		puts "Enter Personal Skills: "
		self.skill = gets.strip
		if skill.match(/.*\S.*/)
		else
			puts "Cannot be left blank"
			intialize_skill
		end
	end

	def intialize_interest
		puts "Enter Personal Interests: "
		self.interest = gets.strip
		if interest.match(/.*\S.*/)
			condition_initilize = true
		else
			puts "Cannot be left blank"
			intialize_interest
		end
	end

	def check_file
		if File.file?("#{name}.txt")
			puts "A file with same name exists"
			puts "Do you wish to over write it ? (y/n): "
			condition_file = gets.strip
			if condition_file == 'y'
				save_to_file
				puts "The file was overwritten"
			elsif condition_file == 'n'
				puts "Again Enter all the details with a different Name"
				Resume.build
			else
				puts "Enter correct input "
			end
		else 
			save_to_file
			puts "New File Created"
		end
	end

	def save_to_file
		aFile = File.new("#{name}.txt","w")
		info = "\tRESUME\n\n Name: #{name}\n Email: #{email}\n Phone No.: #{phone_no}" +
		 			 "\n---------------------------\n Skills: #{skill}\n Interests: #{interest}\n"
		aFile.syswrite(info)
	end

end

Resume.build