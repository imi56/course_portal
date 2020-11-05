class Product < ApplicationRecord
  validates_presence_of :title, :image_url, :description, :provider, :provider_resource_id
  validates_uniqueness_of :provider_resource_id, scope: :provider

  enum product_type: ['Course']

  def self.bulk_upsert(data)
    Product.upsert_all(data, returning: nil, unique_by: %i[ provider_resource_id provider ])
  end
end
