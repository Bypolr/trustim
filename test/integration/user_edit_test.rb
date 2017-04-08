require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  # def setup
  #   @user = users(:michael)
  # end

  # test "unsuccessful edit" do
  #   log_in_as(@user)
  #   get edit_user_path(@user)
  #   assert_template 'users/edit'
  #   patch user_path(@user), params: { user: {
  #       name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" } }
  #   assert_template 'users/edit'
  #   assert_select 'div.alert', /\d errors/
  # end

  # test "successful edit" do
  #   # GET to edit user without login.
  #   get edit_user_path(@user)
  #   # Log in.
  #   log_in_as(@user)
  #   # Redirect to the forwarding_url before logging in. (edit_user_path)
  #   assert_redirected_to edit_user_url(@user)
  #   # Check forwarding_url removed from session.
  #   assert_not session[:forwarding_url]

  #   username = "foobar"
  #   email = "foo@bar.com"
  #   patch user_path(@user), params: {
  #     user: { username: username, email: email, password: "", password_confirmation: "" } }

  #   assert_not flash.empty?
  #   @user.reload

  #   assert_redirected_to @user
  #   assert_equal username, @user.username
  #   assert_equal email, @user.email
  # end
end
