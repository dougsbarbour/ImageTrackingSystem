require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user creation" do
    user = User.create(email: 'a@b.com', password: 'secret')
    found_user = User.authenticate('a@b.com', 'secret')
    refute_nil user
  end
end
