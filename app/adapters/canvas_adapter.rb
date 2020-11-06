class CanvasAdapter
  def self.get_formatted_data
    response = CanvasAPIClient.fetch
    format_response(response['products'])
  end

  private

  def self.format_response(response)
    time = Time.now
    response.map do |prod|
      {
        image_url: prod['image'],
        title: prod['title'],
        description: prod['teaser'],
        price: prod['priceWithCurrency'], #includes currency symbol, ideally currency & price should be separate
        type: prod['type'],
        provider: 'canvas',
        provider_resource_id: prod['id'],
        created_at: time,
        updated_at: time
      }
    end
    
  end
end