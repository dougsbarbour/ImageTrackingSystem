class ImagesController
  class ImageFactory < Object
    attr_accessor :headers_map

    def initialize(*args)
      super(*args)
      @headers_map = Hash.new
    end

    def new_image(*args)
      image = Image.new(*args)
      image.film=(Film.digital) if image.film.nil?
      return image
    end

    def decode_orientation(image)
#      {'L' => :Landscape, 'P' => :Portrait, nil => nil}[image.orientation]
      {'L' => :Landscape, 'P' => :Portrait}[image.orientation]
    end

    def orientation_encoding_map(image)
      {:Landscape => 'L', :Portrait => 'P'}
    end

    def create_images_from_file(file_path, sheet, headers_in_first_row)
      s = SimpleSpreadsheet::Workbook.read(file_path)
      s.selected_sheet = sheet
      image_attributes = Hash.new
      mapped_attributes = @headers_map.values
      associations_map = Hash[Image.reflect_on_all_associations.collect { |each| [each.name.to_s, each] }]
      Image.transaction do
        (headers_in_first_row ? 2 : 1).upto(s.last_row) do |row|
          s.first_column.upto(s.last_column) do |column|
            cell_value = s.cell(row, column)
            attribute_name = mapped_attributes[column-1]
            unless mapped_attributes[column-1].empty?
              if associations_map.keys.include?(attribute_name) # an association to decode
                association = associations_map[attribute_name]
                association_instance = association.klass.find_by(description: cell_value) if cell_value
                if association_instance.nil? && cell_value #create the foreign key instance on the fly
                  association_instance = association.klass.new(description: cell_value)
                  association_instance.save!
                end
                image_attributes[attribute_name] = association_instance
              else # just a regular attribute
                if attribute_name.downcase.include?('date') && cell_value && !cell_value.kind_of?(Date)
                  image_attributes[attribute_name] = Date.parse(cell_value)
                else
                  image_attributes[attribute_name] = cell_value
                end
              end
            end
          end
          Image.new(image_attributes).save!
        end
      end

    end

    def fetch_sheets_from_file(file_path)
      s = SimpleSpreadsheet::Workbook.read(file_path)
      s.sheets
    end

    def fetch_headers_from_file(file_path, sheet)
      s = SimpleSpreadsheet::Workbook.read(file_path)
      s.selected_sheet = sheet
      @headers_map = Hash.new
      s.first_column.upto(s.last_column) do |column|
        @headers_map[s.cell(1, column)] = self.default_field_mapping(s.cell(1, column))
      end
    end

    def fetch_default_headers_from_file(file_path, sheet)
      s = SimpleSpreadsheet::Workbook.read(file_path)
      s.selected_sheet = sheet
      @headers_map = Hash.new(s.last_column - s.first_column + 1)
      index = 1
      ['', *('A'..'Z')].each do
      |first|
        ('A'..'Z').each do
        |second|
          if index > @headers_map.size then
            break
          else
            @headers_map["#{first}#{second}"] = nil
            index += 1
          end
        end
        if index > @headers_map.size then
          break
        end
      end
    end

    def default_field_mapping(column_name)
      ['', *Image.external_attribute_names].inject do |result, field_name|
        field_name.similarity(column_name) > result.similarity(column_name) ? field_name : result
      end
    end
  end
end
