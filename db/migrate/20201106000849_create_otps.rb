class CreateOtps < ActiveRecord::Migration[6.0]
  def change
    create_table :otps do |t|
      t.string :phone, null: false, index: true
      t.string :password, null: false
      t.string :expiry, null: false

      t.timestamps
    end
  end
end
