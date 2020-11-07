class Product < ApplicationRecord  
  DEFAULT_LIMIT = 5
  validates_presence_of :title, :image_url, :description, :provider, :provider_resource_id
  validates_uniqueness_of :provider_resource_id, scope: :provider

  enum product_type: ['Course']

  def product_json
    self.as_json(
      only: [:id, :title, :description, :image_url, :price, :type, :provider, :provider_resource_id]
    )
  end

  def self.bulk_upsert(data)
    Product.upsert_all(data, returning: nil, unique_by: %i[ provider_resource_id provider ])
  end
end
