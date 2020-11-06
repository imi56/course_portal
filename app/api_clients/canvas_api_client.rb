class CanvasAPIClient < BaseAPIClient
  BASE_URL = 'https://www.canvas.net'
  def self.fetch
    puts 'Fetching...'
    get(project_url)
  end

  private
  
  def self.project_url
    "#{BASE_URL}/products.json"
  end
end