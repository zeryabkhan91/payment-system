class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :status
      t.string  :customer_email
      t.string  :customer_phone
      t.string  :type
      t.integer :parent_id
      t.integer :user_id

      t.timestamps
    end
  end
end
