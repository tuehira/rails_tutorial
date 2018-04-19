require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example", email:"user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "a" * 30
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "user@example.com"
    assert @user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end
