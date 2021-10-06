module ApplicationHelper

  def gravatar(user, options = { size: 80 })
    email = user.email.downcase
    hash = Digest::MD5.hexdigest(email)
    size = options[:size]
    img_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(img_url, alt: user.username)
  end

end
