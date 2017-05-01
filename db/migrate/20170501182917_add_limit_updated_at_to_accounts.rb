class AddLimitUpdatedAtToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :limit_updated_at, :timestamp
  end
end
