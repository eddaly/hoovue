CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJ4BVFXZ5PWJCN4OQ',       # required
    :aws_secret_access_key  => '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',       # required

  }
  config.fog_directory  = 'd3-US'                     # required

  def quality(percentage)
    manipulate! do |img|
      img.write(current_path){ self.quality = percentage } unless img.quality == percentage
      img = yield(img) if block_given?
      img
    end
  end

end
