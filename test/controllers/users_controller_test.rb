require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @another_user = users(:archer)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { username: @user.username,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
 end
 
 test "should redirect edit when logged in as wrong user" do
    log_in_as(@another_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@another_user)
    patch user_path(@user), params: { 
      user: { username: @user.username, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@another_user)
    assert_not @another_user.admin?
    patch user_path(@another_user), params: { user: { 
      password:              'password',
      password_confirmation: 'password',
      email: 'test@test.com',
      admin: true } }
    assert_not @another_user.reload.admin?
  end
  
  test "should redirect destroy when logged in as a non-admin user" do
    log_in_as(@another_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url  
  end
  
  test "admin user deletes another user" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@another_user)
    end
    assert_redirected_to users_url
  end
  
end
