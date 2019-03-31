class SocialMediaNormalizer
  def initialize(params)
    @params = params
  end

  SOCIAL_MEDIA = %i|twitter facebook|

  def normalize!
    SOCIAL_MEDIA.each do |sm|
      if @params[sm].present?
        @params[sm] = normalize_username(@params[sm])
      end
    end
  end

  private

  def normalize_username(name)
    name.split('/').last.tr('@', '')
  end
end