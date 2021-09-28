class GameMenu

    @@prompt = TTY::Prompt.new

    def game_loop(player)
        fernsworth = Map.new("Fernsworth")

        divide = "="*100
        puts divide
        puts "Welcome to #{fernsworth.name}"
        puts divide

        choice = @@prompt.select("Welcome to #{fernsworth.name} #{player.name}, what would you like to do?") do |options|
            options.choice "Talk to NPC's"
            options.choice "Open Game Menu"
        end 

        if choice == "Talk to NPC's"
            puts ""
        elsif choice == "Open Game Menu"
            GameMenu.display_game_menu(player)
        end

    end

    def self.display_game_menu(player)
        divide = "="*100
        puts divide
        puts 'Game Menu'
        puts divide

        menu = @@prompt.select("Welcome #{player.name}, what would you like to do?") do |options|
            options.choice "View Map"
            options.choice "Character Options"
            options.choice "Exit Game"
        end

        if menu == "View Map"
            GameMenu.view_map
        elsif menu == "Character Options"
            GameMenu.character_array
        elsif menu == "Exit Game"
            GameMenu.exit_game_menu
        end
    end

    def self.view_map
        

    end

    def self.character_options


    end

    def self.exit_game_menu
        MainMenu.display_menu
    end


end