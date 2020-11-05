class BaseApiClient
  def self.get(url) 
    response = Typhoeus::Request.get(url) 
    parse_json_response(response)
  end

  private

  def self.parse_json_response(response) 
    response_body = JSON.parse(response.body) 
    unless response.success? 
      Rails.logger.error(response_body) 
      raise "Error: while parsing the response: #{response_body}" 
    end 
    response_body
  end 
end