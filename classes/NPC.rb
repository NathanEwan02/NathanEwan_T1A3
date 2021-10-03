begin 
    require 'tty-prompt'
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

class NPC 
    attr_accessor :name, :introduction, :response_1, :response_2

    def initialize(name, introduction, response_1, response_2)
        @name = name
        @introduction = introduction
        @response_1 = response_1
        @response_2 = response_2
    end

    @@prompt = TTY::Prompt.new

    def give_choices(player_response1, player_response2)
        self.class.select_option(Rainbow(@introduction).cyan, [player_response1, player_response2], 2) { |choice|
            if choice == player_response1
                puts Rainbow(@response_1).cyan
            elsif choice == player_response2
                puts Rainbow(@response_2).cyan
            end
        }
    end

    def self.select_option(text, options, num_inputs, &block)
        
        num_inputs.to_i
    
        choice = @@prompt.select(text) do |items|
            items.per_page num_inputs
            items.choices options
        end
    
        block.call(choice)
    end
end 


