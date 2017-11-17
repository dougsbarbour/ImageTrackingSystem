require 'test_helper'

class FilmTest < ActiveSupport::TestCase
  test "film creation" do
    film = Film.create(description: 'Kodak 100')
    found_film = Film.find_by(id: film.id)
    assert_equal 'Kodak 100', found_film.description
  end
end
