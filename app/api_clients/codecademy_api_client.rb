class CodecademyAPIClient < BaseAPIClient
  BASE_URL = 'https://www.codecademy.com'
  def self.fetch
    puts 'Fetching...'
    get(project_url)
  end

  private
  
  def self.project_url
    "#{BASE_URL}/catalog/all.json"
  end
end