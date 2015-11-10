require 'csv'

namespace :create do
	desc "About school model"
	task :school => :environment do
		CSV.foreach('db/seed_data/school_upload.csv', headers: true) do |row|
			School.create(
				id: row[0],
				school_name: row[1]
			)
		end
	end

	desc "About building model"
	task :building => :environment do
		CSV.foreach('db/seed_data/building_upload.csv', headers: true) do |row|
			Building.create(
				id: row[0],
				school_id: row[1],
				building_name: row[2]
			)
		end
	end

	desc "About department model"
	task :department => :environment do
		CSV.foreach('db/seed_data/department_upload.csv', headers: true) do |row|
			Department.create(
				id: row[0],
				school_id: row[1],
				department_name: row[2]
			)
		end
	end

	desc "About professor model"
	task :professor => :environment do
		CSV.foreach('db/seed_data/professor_upload.csv', headers: true) do |row|
			Professor.create(
				id: row[0],
				department_id: row[1],
				professor_name: row[2]
			)
		end
	end

	desc "About classification model"
	task :classification => :environment do
		CSV.foreach('db/seed_data/classification_upload.csv', headers: true) do |row|
			Classification.create(
				id: row[0],
				school_id: row[1],
				classification_name: row[2]
			)
		end
	end

	desc "About lecture model"
	task :lecture => :environment do
		CSV.foreach('db/seed_data/lecture_upload.csv', headers: true) do |row|
			Lecture.create(
				id: row[0],
				department_id: row[1],
				professor_id: row[2],
				classification_id: row[3],
				year: row[4],
				semester: row[5],
				lecture_name: row[6],
				level: row[7],
				lecture_number: row[8],
				lecture_division: row[9],
				grade: row[10],
				relative: row[11],
				passfail: row[12],
				english: row[13],
				active: row[14]
			)
		end
	end

	desc "About lecturetime model"
	task :lecturetime => :environment do
		CSV.foreach('db/seed_data/lecturetime_upload.csv', headers: true) do |row|
			Lecturetime.create(
				lecture_id: row[0],
				classroom_id: row[1],
				day: row[2],
				starttime: row[3],
				endtime: row[4]
			)
		end
	end

	desc "About classroom model"
	task :classroom => :environment do
		CSV.foreach('db/seed_data/classroom_upload.csv', headers: true) do |row|
			Classroom.create(
				id: row[0],
				building_id: row[1],
				classroom_name: row[2]
			)
		end
	end
end
