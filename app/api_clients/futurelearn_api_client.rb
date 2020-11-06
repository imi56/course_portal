class FuturelearnAPIClient < BaseAPIClient
  BASE_URL = 'https://www.futurelearn.com'
  def self.fetch
    puts 'Fetching...'
    get(project_url)
  end

  private
  
  def self.project_url
    "#{BASE_URL}/feeds/courses.json"
  end
end