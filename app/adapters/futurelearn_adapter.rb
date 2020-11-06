class FuturelearnAdapter
  def self.get_formatted_data
    response = FuturelearnAPIClient.fetch
    format_response(response)
  end

  private

  def self.format_response(response)
    time = Time.now
    response.map do |prod|
      {
        image_url: prod['image_url'],
        title: prod['name'],
        description: prod['introduction'],
        provider: 'futurelearn',
        provider_resource_id: prod['uuid'],
        created_at: time,
        updated_at: time
      }
    end
    
  end
end