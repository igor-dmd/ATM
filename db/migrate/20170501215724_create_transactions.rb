class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :target_acc_number
      t.string :target_branch
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
