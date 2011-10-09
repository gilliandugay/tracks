require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should save without login and with email" do
    user = User.new(:email => 'test@test.com', :password => 'test123')
    assert user.save
  end

  test "should not save without login and email" do
    user = User.new(:password => 'test123')
    assert !user.save
  end

  test "should authenticate with login" do
    user = User.create(:email => 'test@test.com', :login => 'tester', :password => 'test123')
    assert_equal user, User.authenticate(user.login, user.password)
  end

  test "should authenticate with email" do
    user = User.create(:email => 'test@test.com', :login => 'tester', :password => 'test123')
    assert_equal user, User.authenticate(user.email, user.password)
  end

  test "should not authenticate with incorrect login" do
    user = User.create(:email => 'test@test.com', :login => 'tester', :password => 'test123')
    assert_nil User.authenticate('wrong_tester', user.password)
  end

  test "should not authenticate with incorrect email" do
    user = User.create(:email => 'test@test.com', :login => 'tester', :password => 'test123')
    assert_nil User.authenticate('wrong@test.com', user.password)
  end

  test "should not authenticate with incorrect password" do
    user = User.create(:email => 'test@test.com', :login => 'tester', :password => 'test123')
    assert_nil User.authenticate(user.email, 'mistest123')
  end
end