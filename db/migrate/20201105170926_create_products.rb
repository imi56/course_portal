class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.text :title, index: true, null: false
      t.text :description, null: false
      t.text :image_url, null: false
      t.string :price
      t.integer :product_type
      t.string :provider, null: false
      t.string :provider_resource_id, null: false

      t.timestamps
    end
    add_index :products, [:provider_resource_id, :provider], unique: true
  end
end
