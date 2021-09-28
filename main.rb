require 'tty-prompt'
require_relative "classes/main_menu"
require_relative "classes/character"
require_relative "classes/game_menu"
require_relative "classes/map"

prompt = TTY::Prompt.new

divide = "="*100

berwig = Character.new("Berwig", "Elf", "Sheriff")
ravenna = Character.new("Revanna", "Elf", "Barkeep")
jabal = Character.new("Jabal", "Elf", "Merchant")

fernsworth = Map.new("Fernsworth", [berwig, ravenna, jabal])
lerwick = Map.new("Lerwick", [])
saxondale = Map.new("Saxondale", [])

def create_title(title, divide)
    puts divide
    puts title
    puts divide
end

def select_option(text, options, prompt, num_inputs)
    num_inputs.to_i

    choice = prompt.select(text) do |items|
        items.per_page num_inputs
        items.choices options
    end

end

main_menu = true

while main_menu == true
    create_title("Main Menu", divide)

    choice = prompt.select("What would you like to do?") do |item|
        item.choice "New Game"
        item.choice "Options"
        item.choice "Exit"
    end
    puts divide

    if choice == "New Game"
        character_array = []

        Character.setup(divide, create_title("Character Creator", divide))
        Character.get_char_array(character_array)

        player = Character.new(character_array[0], character_array[1], character_array[2])

        game_loop = true 
        
        while game_loop == true
            create_title(fernsworth.name, divide)
        
            choice = prompt.select("Welcome to #{fernsworth.name} #{player.name}, what would you like to do?") do |options|
                options.choice "Talk to NPC's"
                options.choice "Open Game Menu"
            end 
            puts divide 

            if choice == "Talk to NPC's"
                talk_to = prompt.select("Who would you wish to speak to first? ") do |people|
                    people.choice "Berwig"
                    people.choice "Ravenna"
                    people.choice "Jabal"
                end

                if talk_to == "Berwig"
                    select_option("Well hello there traveler! May I ask your help?", ["Yes", "No"], prompt, 2)

                elsif talk_to == "Ravenna"
                    puts ""
                elsif talk_to == "Jabal"
                    puts ""
                end

            elsif choice == "Open Game Menu"
                GameMenu.display_game_menu(player)
            end
        end

    elsif choice == "Options"
        puts "opt"
    elsif choice == "Exit"
        main_menu == false
    end







end 

# # divide = "="*100
# # puts divide
# puts 'Main Menu'
# puts divide
# prompy = Prompt.new
# choice = prompt.select("What would you like to do?") do |item|
#     item.choice "New Game"
#     item.choice "Options"
#     item.choice "Exit"
# end
# puts divide

# if choice == "New Game"
#     # MainMenu.new_game
#     array = []

#     Character.setup
#     Character.get_char_array(array)

#     player = Character.new(array[0], array[1], array[2])

#     game = GameMenu.new
#     game.game_loop(player)
# elsif choice == "Options"
#     MainMenu.options
# elsif choice == "Exit"
    
#     MainMenu.exit_game
# end