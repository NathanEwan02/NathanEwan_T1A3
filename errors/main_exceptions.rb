#Each begin statment checks to see if the ruby gem is installed
begin
    require 'tty-prompt' 
rescue LoadError => e 
    puts "A dependency was unable to load: "
    puts e.message
    puts "Try installing dependencies manually using \"bundle install\" from within the directory"
    exit
end

begin
    require 'csv' 
rescue LoadError => e 
    puts "A dependency was unable to load: "
    puts e.message
    puts "Try installing dependencies manually using \"bundle install\" from within the directory"
    exit
end

begin
    require 'artii' 
rescue LoadError => e 
    puts "A dependency was unable to load: "
    puts e.message
    puts "Try installing dependencies manually using \"bundle install\" from within the directory"
    exit
end

begin
    require 'rainbow' 
rescue LoadError => e 
    puts "A dependency was unable to load: "
    puts e.message
    puts "Try installing dependencies manually using \"bundle install\" from within the directory"
    exit
end

