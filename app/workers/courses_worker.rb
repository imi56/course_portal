class CoursesWorker
  # this mapping is needed to avoid duplicate code
  PROVIDER_ADAPTER_MAPPING = {
    canvas: 'CanvasAdapter',
    codecademy: 'CodecademyAdapter',
    futurelearn: 'FuturelearnAdapter',
  }
  def self.sync
    PROVIDER_ADAPTER_MAPPING.each do |adtp|
      puts "Syncing #{adtp.first}"
      begin
        data = Object.const_get(adtp.second).get_formatted_data
        Product.bulk_upsert(data)
      rescue StandardError => e
        Rails.logger.error("Product sync failed: #{e}")
      end
      puts 'Done'
    end
  end
end
