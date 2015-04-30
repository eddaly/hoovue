module UsersHelper

  def profile_image_tag user, options, html_options
    image = (user.profile_picture  || '/assets/beta/placeholder-user.png')
    image_tag image, html_options
  end

end
