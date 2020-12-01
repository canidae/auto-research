require "zip"
require "json"

json = IO.read "info.json"
info = JSON.parse( json, { :symbolize_names => true } )

puts "Packing Auto Research version #{info[:version]}"

all_files   = Dir["**/*"].reject { | f | File.directory?( f ) || f =~ /\.(rb|zip)$/i }
proper_name = "#{File.basename Dir.pwd}_#{info[:version]}"
zip_name    = proper_name + ".zip"

File.delete( zip_name ) if File.exist?( zip_name ) && File.file?( zip_name )

Zip::File.open( zip_name, Zip::File::CREATE ) do | zipfile |
    all_files.each do | filename |
        zipfile.add( File.join( proper_name, filename ), File.join( Dir.pwd, filename ) )
    end
end

