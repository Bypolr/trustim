require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # def setup
  #   @admin = users(:michael)
  #   @non_admin = users(:archer)
  # end

  # test "index as admin including pagination and delete links" do
  #   log_in_as(@admin)
  #   get users_path(@admin.username)
  #   assert_template 'users/index'
  #   assert_select 'div.pagination'
  #   first_page_of_users = User.paginate(page: 1)
  #   first_page_of_users.each do |user|
  #     assert_select 'a[href=?]', user_url(user.username), text: user.username
  #     # unless user == @admin
  #     #   assert_select 'a[href=?]', user_url(user.username), text: 'delete'
  #     # end
  #   end
  #   assert_difference 'User.count', -1 do
  #     delete user_path(@non_admin.username)
  #   end
  # end

  # test "index as non_admin" do
  #   log_in_as(@non_admin)
  #   get users_path(@non_admin.username)
  #   assert_select 'a', text: 'delete', count: 0
  # end
end
