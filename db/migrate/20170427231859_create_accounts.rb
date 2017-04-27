class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.string :account_number
      t.string :branch
      t.string :token
      t.integer :limit

      t.timestamps
    end
  end
end
