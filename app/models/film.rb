class Film < ApplicationRecord
  has_many :images

  def self.digital
    if (r = self.find_by(description: 'Digital')).nil?
      r = self.create(description: 'Digital')
    end
    return r
  end

  def to_s
    self.description.to_s
  end

end
