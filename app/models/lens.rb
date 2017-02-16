class Lens < ApplicationRecord
  has_many :images

  def to_s
    self.description.to_s
  end

end
