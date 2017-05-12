# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

10.times do
  user = User.create!( full_name: FFaker::NameBR.name,
                       cpf: 11.times.map{rand( 10 )}.join,
                      birthday_date: FFaker::Time.between( 50.years.ago, 20.years.ago ),
                      gender: rand( 2 ),
                      password: Digest::SHA256.hexdigest( FFaker::Internet.password ) )

  address = Address.create!( street_name: FFaker::AddressBR.street + ", " + FFaker::AddressBR.building_number,
                       city: FFaker::AddressBR.city,
                       state: FFaker::AddressBR.state,
                       country: 'Brazil',
                             user_id: user.id )

  user.address = address
  user.save!
end

