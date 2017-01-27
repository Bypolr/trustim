require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	test "layout links" do
	  get root_path
	  assert_template 'static_pages/home'
	  assert_select "a[href=?]", root_path, 2
	  assert_select "a[href=?]", help_path
	  assert_select "a[href=?]", contact_path
	  assert_select "a[href=?]", about_path
	end

	test "visit sign up page" do
		get signup_path
		assert_template 'users/new'
	end
end
