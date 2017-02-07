module UsersHelper
	def gravatar_for(user, options = {})
    options_default = { size: 80 }
    options.reverse_merge!(options_default)

		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{options[:size]}"
		image_tag(gravatar_url, alt: user.username, class: "gravatar")
	end
end
