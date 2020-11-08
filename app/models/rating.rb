class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates_presence_of :product, :rating
  validates_numericality_of :rating, message: 'should be an integer'
  validates_uniqueness_of :product, scope: :user

  def rating_json
    self.as_json(
      only: [:id, :rating]
    )
  end
end
