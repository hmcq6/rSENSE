class CSV_Converter
  require 'csv'
  
  def convert( file )
    possible_separators = [",", "\t", ";"]
    
    #delimters
    delim = Array.new
    
    possible_separators.each_with_index do |sep, index|
      
      delim[index] = Hash.new
      delim[index][:input] = file
      delim[index][:file] = Roo::CSV.new( file.path, csv_options: {col_sep: sep, quote_char: "\'", force_quotes: 0, converters: :all})
      delim[index][:data] = delim[index][:file].parse()
      delim[index][:avg] = 0
      
      delim[index][:data].each do |row|
        delim[index][:avg] = delim[index][:avg] + row.count
      end
      
      delim[index][:avg] = delim[index][:avg] / delim[index][:data].count
      
    end
        
    possible_separators.each_with_index do |sep, index|
      if( delim[index][:data].first.count == delim[index][:avg] and delim[index][:data].last.count == delim[index][:avg] and delim[index][:avg] > 1)
        
        return delim[index][:file]
        
      end
    end
    
    delim[0][:file]
    
  end
end