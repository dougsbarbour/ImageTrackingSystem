require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category creation" do
    category = Category.create(description: 'National Parks')
    found_category = Category.find_by(id: category.id)
    assert_equal 'National Parks', found_category.description
  end
end
