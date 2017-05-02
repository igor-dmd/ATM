class AddCashToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :cash, :integer
  end
end
