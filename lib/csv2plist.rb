require 'csv'
require 'plist'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


module Csv2plist
  def self.convert(src, dst, opts={})
    rows = CSV.read(src)
    cols = rows[0]
    entries = {}
    puts "Columns: #{cols.inspect}"
    
    startIndex = 1
    if cols.length == 2
      startIndex = 0
    end
    
    (1..rows.length-1).each do |row|
      vals = rows[row]
      dict = {}
      if cols.length > 2
        cols.each_with_index do |c,i|
          if vals[i]
            value = vals[i].strip
            dict[c] = value if c && value.length > 0
          end
        end
      else
        dict = vals[1].strip
      end
      entries[vals[0]] = dict
    end
    entries.save_plist(dst)
  end
end
