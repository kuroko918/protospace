CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      region: Settings.aws.region
  }

  case Rails.env
    when 'production'
      config.storage = :fog
        config.fog_directory = 'protospace-iwamoto'
        config.asset_host = 'https://s3.amazonaws.com/protospace-iwamoto'
    when 'development'
      config.storage = :fog
        config.fog_directory = 'protospace-iwamoto'
        config.asset_host = 'https://s3.amazonaws.com/protospace-iwamoto'
    when 'test'
      config.storage = :file
  end
end
