require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
		  post users_path,
		       params: { user: { name: "",
		       	                 email: "user@invalid",
		  		                   password: "foo",
		  		                   password_confirmation: "bar"
		  		                 } }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.field_with_errors'
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: {user: {
				username: 'yiliang111',
				email:'ydatylmon@gmail.com',
				password: 'qqq111',
				password_confirmation: 'qqq111'
				}}
		end

		follow_redirect!
		assert_template 'users/show'
		assert_not flash.empty?
    assert is_logged_in?
	end
end
