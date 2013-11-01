class CSV_Converter
  def convert( file )
    if file.content_type.include? "opendocument"
      oo = Roo::Openoffice.new(file.path,false, :ignore)
      data = CSV.parse(oo.to_csv)
      data
    elsif file.content_type.include? "ms-excel"
      oo = Roo::Excel.new(file.path,false,:ignore)
      data = CSV.parse(oo.to_csv)
      data
    elsif file.content_type.include? "openxmlformats"
      oo = Roo::Excelx.new(file.path,false,:ignore)
      data = CSV.parse(oo.to_csv)
      data
    elsif file.original_filename.split(".").last == "csv" or file.original_filename.split(".").last == "txt"
      possible_separators = [",", "\t", ";"]
      
      #delimters
      delim = Array.new
      
      possible_separators.each_with_index do |sep, index|
        
        delim[index] = Hash.new
        delim[index][:file] = CSV.open( file.path, 'r', {col_sep: sep, quote_char: "\'", force_quotes: 0, converters: :all})
        delim[index][:file] = delim[index][:file].read()
        delim[index][:avg] = 0
        
        delim[index][:file].each do |row|
          delim[index][:avg] = delim[index][:avg] + row.count
        end
        
        delim[index][:avg] = delim[index][:avg] / delim[index][:file].count
        
      end
      
      Rails.logger.info delim[0][:file].count
      
      possible_separators.each do |sep, index|
        if( delim[index][:file].count == delim[index][:avg] and delim[index][:file].last.count == delim[index][:avg] and delim[index][:avg] > 1)
        
          return delim[index][:file]
        
        end
      end
      
      delim[0][:file]
      
    else
      error = "File type not supported."
    end
  end
end