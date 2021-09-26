
class MainMenu 
    def initialize()
        @prompt = TTY::Prompt.new
    end 

    def display_menu 
        divide = "="*100
        puts divide
        puts 'Main Menu'
        puts divide

        choice = @prompt.select("What would you like to do?") do |item|
            item.choice "New Game"
            item.choice "Options"
            item.choice "Exit"
        end
        puts divide

        if choice == "New Game"
            MainMenu.new_game
        elsif choice == "Options"
            options
        elsif choice == "Exit"
            exit_game
        end
    end 


    def self.new_game()
        Character.setup

    end

    def self.options
        puts "hi"
    end

    def self.exit_game
        puts "hello"

    end
end








