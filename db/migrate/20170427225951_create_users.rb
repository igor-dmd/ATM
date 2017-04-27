class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :cpf
      t.date :birthday_date
      t.integer :gender
      t.string :password

      t.timestamps
    end
  end
end
