module ImageUrl
  extend ActiveSupport::Concern

  def image_url
    image.url if image.attached?
  end
end
