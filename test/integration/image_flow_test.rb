require 'test_helper'

class ImageFlowTest < Capybara::Rails::TestCase
  def setup
    @one = images(:one)
    @two = images(:two)
  end

  test 'image index' do
    visit images_path

    assert page.has_content?(@one.description)
    assert page.has_content?(@two.description)
  end
end