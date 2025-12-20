class AddSomeCountries < ActiveRecord::Migration[8.1]
  def change
    Country.create(name: "Slovenija").save!
    Country.create(name: "Avstrija").save!
    Country.create(name: "Italija").save!
    Country.create(name: "Švica").save!
  end
end
