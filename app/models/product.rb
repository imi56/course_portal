class Product < ApplicationRecord  
  attr_accessor :user_id_for_rating
  DEFAULT_LIMIT = 5
  validates_presence_of :title, :image_url, :description, :provider, :provider_resource_id
  validates_uniqueness_of :provider_resource_id, scope: :provider

  has_many :ratings

  enum product_type: ['course', "n/a"]

  def user_rating
    rating = ratings.find_by(user_id: user_id_for_rating)
    return {} unless rating
    rating.rating_json
  end

  def product_json_for(user)
    self.user_id_for_rating = user.id
    self.as_json(
      only: [:id, :title, :description, :image_url, :price, :product_type, :provider, :provider_resource_id, :resource_url],
      methods: [:user_rating]
    )
  end

  def self.bulk_upsert(data)
    Product.upsert_all(data, returning: nil, unique_by: %i[ provider_resource_id provider ])
  end
end
