class Resume

	attr_accessor :name, :email, :phone_no, :skill, :interest, :file_type
end

class ResumeBuilder

	def initialize(resume_object)
		@resume_object = resume_object
		build
	end

	def build
		intialize_name
		intialize_email
		intialize_phone_no
		intialize_skill
		intialize_interest
		input_file_type
	end

	def intialize_name
		puts "Enter Name: "
		@resume_object.name = gets.strip
		if @resume_object.name.match(/^[a-z ,.'-]+$/i)
		else
			puts "Name entered is not valid"
			intialize_name
		end
	end

	def intialize_email
		puts "Enter Email: "
		@resume_object.email = gets.strip
		if @resume_object.email.match('^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,4}$')
		else
			puts "Email is not valid"
			intialize_email
		end
	end

	def intialize_phone_no
		puts "Enter Phone No.: "
		@resume_object.phone_no = gets.strip.delete(' ')
		if @resume_object.phone_no.match('^[0-9]{10,11}')
		else
			puts "Phone No. not valid"
			intialize_phone_no
		end
	end

	def intialize_skill
		puts "Enter Personal Skills: "
		@resume_object.skill = gets.strip
		if @resume_object.skill.match(/.*\S.*/)
		else
			puts "Cannot be left blank"
			intialize_skill
		end
	end

	def intialize_interest
		puts "Enter Personal Interests: "
		@resume_object.interest = gets.strip
		if @resume_object.interest.match(/.*\S.*/)
			condition_initilize = true
		else
			puts "Cannot be left blank"
			intialize_interest
		end
	end

	def input_file_type
		puts "Enter which type of file is to be created ?\n1 -> Text File\n2 -> CSV File\n3 -> PDF File\n"
		@resume_object.file_type = gets.strip
		case @resume_object.file_type
		when "1"
			@resume_object.file_type = ".txt"
			puts "Its a Text File"
			text_object = TextFile.new(@resume_object)
			text_object.save
		when "2"
			@resume_object.file_type = ".csv"
			puts "Its a CSV File"
			csv_object = CsvFile.new(@resume_object)
			csv_object.save
		when "3"
			@resume_object.file_type = ".pdf"
			puts "Its a PDF File"
			pdf_object = PdfFile.new(@resume_object)
			pdf_object.save
		else
			puts "Improper Inputs please enter Again"
			input_file_type
		end	
	end

end

class Media

	def initialize(resume_object)
		@resume_object = resume_object
	end

	def check_file
		if File.exists?("#{@resume_object.name}#{@resume_object.file_type}")
			puts "A file with same name exists"
			puts "Do you wish to over write it ? (y/n): "
			condition_file = gets.strip
			if condition_file == 'y'
				puts "The file was overwritten"
			elsif condition_file == 'n'
				puts "Again Enter all the details with a different Name"
				resumebuilder_object = ResumeBuilder.new(@resume_object)
				resumebuilder_object.build
			else
				puts "Enter correct input "
			end
		else 
			puts "New File Created"
		end
	end

end

class TextFile < Media

	def save
		check_file
		aFile = File.new("#{@resume_object.name}.txt","w")
		info = "\tRESUME\n\n Name: #{@resume_object.name}\n Email: #{@resume_object.email}\n Phone No.: #{@resume_object.phone_no}" +
		 			 "\n---------------------------\n Skills: #{@resume_object.skill}\n Interests: #{@resume_object.interest}\n"
		aFile.syswrite(info)
		
	end

end

class CsvFile < Media

	require 'csv' 

	def save
		check_file
		CSV.open("#{@resume_object.name}.csv","w") do |csv|
			csv << ["Name", "Email", "Phone No.", "Skills", "Interests"]
			csv << [" #{@resume_object.name}", " #{@resume_object.email}", 
						 " #{@resume_object.phone_no}", " #{@resume_object.skill}", " #{@resume_object.interest}"]
		end
	end

end	

class PdfFile < Media 

	require 'prawn'

	def save
		Prawn::Document.generate("#{@resume_object.name}.pdf") do |pdf|
			pdf.text "\tRESUME\n\n Name: #{@resume_object.name}\n Email: #{@resume_object.email}\n Phone No.: #{@resume_object.phone_no}" +
			 			   "\n---------------------------\n Skills: #{@resume_object.skill}\n Interests: #{@resume_object.interest}\n"
		end
	end

end
resume_object = Resume.new
media_object = Media.new(resume_object)
resumebuilder_object = ResumeBuilder.new(resume_object)
