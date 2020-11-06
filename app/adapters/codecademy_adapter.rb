class CodecademyAdapter
  def self.get_formatted_data
    response = CodecademyAPIClient.fetch
    format_response(response['entities']['paths']['byId'].values)
  end

  private

  def self.format_response(response)
    time = Time.now
    response.map do |prod|
      {
        image_url: prod['splash_image']['url'],
        title: prod['title'],
        description: prod['short_description'],
        provider: 'codecademy',
        provider_resource_id: prod['id'],
        created_at: time,
        updated_at: time
      }
    end
    
  end
end