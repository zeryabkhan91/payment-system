class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :amount
      t.string :status
      t.string  :customer_email
      t.string  :customer_phone
      t.string  :type, default: 'AuthorizeTransaction'
      t.integer :parent_id
      t.references :user 

      t.timestamps
    end
  end
end
