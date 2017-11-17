require 'test_helper'

class LensTest < ActiveSupport::TestCase
  test "lens creation" do
    lens = Lens.create(description: 'Sigma 50mm')
    found_lens = Lens.find_by(id: lens.id)
    assert_equal 'Sigma 50mm', found_lens.description
  end
end
