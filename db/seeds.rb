# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.find_or_create_by!(name: 'State Admin')
Role.find_or_create_by!(name: 'Regional Admin')
Role.find_or_create_by!(name: 'Teacher')
Role.find_or_create_by!(name: 'Parent')

teacher = User.find_or_create_by!(clerk_id: 'user_123456')
parent = User.find_or_create_by!(clerk_id: 'user_123457')

Assignment.find_or_create_by!(user_id: teacher.id, role_id: 3)
Assignment.find_or_create_by!(user_id: parent.id, role_id: 4)

student = Student.find_or_create_by!(first_name: "Ja'mie", last_name: 'Tsunami', dob: DateTime.now.years_ago(15), grade: 10, user_id: parent.id)
