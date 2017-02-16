class Image < ApplicationRecord
  has_attached_file :thumbnail, :styles => { :medium => "300x300", :thumb => "100x100>"}, :default_url => "/missing.png"
  validates_attachment_content_type :thumbnail, content_type: ["image/jpeg", "image/gif", "image/png"]
  belongs_to :category
  belongs_to :film, optional: true
  belongs_to :lens, optional: true

  def self.external_attribute_names
    ans = Array.new(self.attribute_names)
    Image.reflect_on_all_associations.each do |assoc|
      ans[ans.index(assoc.foreign_key)] = assoc.name.to_s
    end
    return ans.sort
  end

  def initialize(*args)
    super(*args)
    self.dateTaken=(Date.today) if self.dateTaken.nil?
  end
end
