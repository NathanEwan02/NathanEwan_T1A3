class GameMenu

    def initialize()
        @prompt = TTY::Prompt.new
    end

    def display_game_menu
        divide = "="*100
        puts divide
        puts 'Game Menu'
        puts divide

        menu = @prompt.select("Welcome, what would you like to do?") do |options|
            options.choice "View Map"
            options.choice "Character Options"
            options.choice "Exit Game"
        end

        if menu == "View Map"
            puts "map"
        elsif menu == "Character Options"
            puts "char op"
        elsif menu == "Exit Game"
            puts "Exit"
        end
    end


end