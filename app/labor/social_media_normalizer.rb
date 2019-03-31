class SocialMediaNormalizer
  def initialize(params)
    @params = params
  end
  
  def normalize!
    SOCIAL_MEDIA.each do |sm, callback|
      if @params[sm].present?
        @params[sm] = callback.call(@params[sm])
      end
    end
  end

  DEFAULT_NORMALIZER = proc { |name|
    name.split('/').last.tr('@', '')
  }

  SOCIAL_MEDIA = {
    twitter:  DEFAULT_NORMALIZER,
    facebook: DEFAULT_NORMALIZER,
    discord: proc { |name| 
      next name unless name.match? /\w+\s?#\d{4}/
      name.sub(/\b#/, ' #').strip
    },
  }

  private_constant :DEFAULT_NORMALIZER, 
                   :SOCIAL_MEDIA
end