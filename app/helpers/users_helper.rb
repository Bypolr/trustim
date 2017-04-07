module UsersHelper
	def gravatar_for(user, options = {})
    options_default = { size: 80, class: "gravatar" }
    options.reverse_merge!(options_default)

		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{options[:size]}"
		image_tag(gravatar_url, alt: user.username, class: options[:class])
	end

  def show_unread_count
    if logged_in? && current_user.unread_count > 0
      content_tag(:div, "You have #{current_user.unread_count} unread messages.", class: "alert alert-info")
    end
  end
end
