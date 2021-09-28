
class MainMenu 
    @@prompt = TTY::Prompt.new
    
    def self.display_menu 
        divide = "="*100
        puts divide
        puts 'Main Menu'
        puts divide

        choice = @@prompt.select("What would you like to do?") do |item|
            item.choice "New Game"
            item.choice "Options"
            item.choice "Exit"
        end
        puts divide

        if choice == "New Game"
            MainMenu.new_game
        elsif choice == "Options"
            MainMenu.options
        elsif choice == "Exit"
            MainMenu.exit_game
        end
    end 

    # -
    #     -
    #         -
    #             -
    #                 -


    # main_menu = true
    # -
    #     sub_menu = true
    #     -
    #         sub_menu_one = true
    #         -
    #         -
    #             sub_menu_one = false
    #     -
    #     -
    #     -
    #         sub_menu = false


    def self.new_game
        array = []

        Character.setup()
        Character.get_char_array(array)

        player = Character.new(array[0], array[1], array[2])
    
        game = GameMenu.new
        game.game_loop(player)
        #game.display_game_menu(player)
    end


    def self.options
        puts "hi"
    end


    def self.exit_game
        puts "hello"

    end
end








