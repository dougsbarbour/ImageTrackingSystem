require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test "image creation" do
    lens = Lens.create(description: '50mm')
    film = Film.digital
    category = Category.create(description: 'National Parks')
    image_params = {idSuffix: 'idSuffix',
                    description: 'description',
                    location: 'location',
                    description2: 'description2',
                    dateTaken: Date.today,
                    orientation: 'L',
                    keywords: 'keywords',
                    notes: 'notes',
                    lens: lens,
                    film: film,
                    category: category,
                    thumbnail: sample_file("sample_file.jpg")}
    image = Image.new(image_params)
    image.save!
    found_image = Image.find_by(id: image.id)
    assert_equal image_params[:description], found_image.description
    assert_equal image_params[:location], found_image.location
    assert_equal image_params[:description2], found_image.description2
    assert_equal image_params[:dateTaken], found_image.dateTaken
    assert_equal image_params[:orientation], found_image.orientation
    assert_equal image_params[:keywords], found_image.keywords
    assert_equal image_params[:notes], found_image.notes
    assert_equal image_params[:lens], found_image.lens
    assert_equal image_params[:film], found_image.film
    assert_equal image_params[:category], found_image.category
    refute_nil found_image.thumbnail
    found_image.thumbnail = nil
    found_image.save!
    found_image.reload
    refute found_image.thumbnail.present?
  end
end
