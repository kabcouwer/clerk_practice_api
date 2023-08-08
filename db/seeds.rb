# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = Role.create([{ name: 'State Admin' }, { name: 'Regional Admin' }, { name: 'Teacher' }, { name: 'Parent' }])

User.find_or_create_by(first_name: 'Mr.', last_name: 'G', email: 'mr.g@test.com', phone_number: '123-456-7890', street_address: '123 Maple St', city: 'Ann Arbor', state: 'MI', zip_code: '48103')
User.find_or_create_by(first_name: 'Johnny', last_name: 'Tsunami', email: 'johnny.tsunami@test.com', phone_number: '123-456-7891', street_address: '123 Main St', city: 'Honolulu', state: 'HI', zip_code: '12345')

Assignment.find_or_create_by(user_id: 1, role_id: 3)
Assignment.find_or_create_by(user_id: 2, role_id: 4)

Student.find_or_create_by(first_name: "Ja'mie", last_name: 'Tsunami', user_id: 2)
