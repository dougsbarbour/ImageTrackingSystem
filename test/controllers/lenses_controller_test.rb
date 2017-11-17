require 'test_helper'

class LensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lens = lenses(:one)
  end

  test "should get index" do
    get lenses_url
    assert_response :success
  end

  test "should get new" do
    get new_lens_url
    assert_response :success
  end

  test "should create lens" do
    assert_difference('Lens.count') do
      post lenses_url, params: { lens: {description: @lens.description} }
    end

    assert_redirected_to lens_url(Lens.last)
  end

  test "should show lens" do
    get lens_url(@lens)
    assert_response :success
  end

  test "should get edit" do
    get edit_lens_url(@lens)
    assert_response :success
  end

  test "should update lens" do
    patch lens_url(@lens), params: { lens: {description: @lens.description} }
    assert_redirected_to lens_url(@lens)
  end

  test "should destroy lens" do
    assert_difference('Lens.count', -1) do
      delete lens_url(@lens)
    end

    assert_redirected_to lenses_url
  end
end
