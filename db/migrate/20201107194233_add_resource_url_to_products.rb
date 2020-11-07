class AddResourceUrlToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :resource_url, :text
  end
end
