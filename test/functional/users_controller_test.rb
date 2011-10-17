require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user" do
    attributes = { :login => 'newuser', :password => 'password', :email => 'test@example.com' }.stringify_keys
    assert_difference('User.count') do
      post :create, :user => attributes
    end
    assert_response :success
    assert_equal attributes.slice('login', 'email'), assigns(:user).attributes.slice('login', 'email')
  end

  test "should update user" do
    user = User.create(:login => 'newuser', :password => 'password', :email => 'test@example.com')
    email = 'new.test@example.com'
    put :update, {:id => user.id, :user => { :email => email }}
    assert_response :success
    assert_equal assigns(:user).email, email
  end

  test "should fetch user" do
    user = User.create(:login => 'newuser', :password => 'password', :email => 'test@example.com')
    get :fetch, {:id => user.id}
    assert_response :success
    assert_equal response.content_type, 'application/json'
    assert_equal response.body, user.to_json
  end
end