require 'tty-prompt'
require 'csv'

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
saxondale = Map.new("Saxondale", [])

character_array = []

player = Character.new("", "", "")

def create_title(title, divide)
    puts divide
    puts title
    puts divide
end

def select_option(text, options, prompt, num_inputs, &block)
    num_inputs.to_i

    choice = prompt.select(text) do |items|
        items.per_page num_inputs
        items.choices options
    end

    block.call(choice)
end

def talk_to_npcs(list_of_people, &block)
    prompt = TTY::Prompt.new
    talk_to = prompt.select("Who would you wish to speak to first?", list_of_people)

    # yield
    block.call(talk_to)
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

        select_option("Would you like to use an old character?", ["Yes", "No"], prompt, 2) {|choice|
            if choice == "Yes"
                csv = CSV.read("player.csv", header: true)
                puts csv.find {|row| row['name'] == 'James'}
            else 
                Character.setup(divide, create_title("Character Creator", divide))
                Character.get_char_array(character_array)
            end
        }

        player = Character.new(character_array[0], character_array[1], character_array[2])
        # character_array = []

        # Character.setup(divide, create_title("Character Creator", divide))
        # Character.get_char_array(character_array)

        # player = Character.new(character_array[0], character_array[1], character_array[2])

        # CSV.open('player.csv', 'a') do |csv|
        #     csv << [name_var, 18, 'male']
        # end

        game_loop = true 
        
        while game_loop == true
            create_title(fernsworth.name, divide)

            # location = new Area("tavern", [
            #     new Person("John", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" }),
            #     new Person("Paul", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" }),
            #     new Person("Adam", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" }),
            # ])
        
            choice = prompt.select("Welcome to #{fernsworth.name} #{player.name}, what would you like to do?") do |options|
                options.choice "Talk to NPC's"
                options.choice "Open Game Menu"
            end 
            puts divide 

            if choice == "Talk to NPC's"
                # location.talk_to_npcs
                talk_to_npcs([berwig.name, ravenna.name, jabal.name]) {|talk_to| 
                    if talk_to == "Berwig"
                        select_option("Well hello there traveler! May I ask your help?", ["Yes", "No"], prompt, 2) {|choice| 
                            if choice == "Yes"
                                puts "great here is your quest....."
                            else 
                                puts "thats a shame, have a good day"
                            end
                        }
                    elsif talk_to == "Ravenna"
                        select_option("Well hello there traveler! Give me all your gold?", ["Yes", "No"], prompt, 2) {|choice| 
                            if choice == "Yes"
                                puts "pleasure doing business with you"
                            else 
                                puts "Ive fought mudcrabs tougher than you"
                            end
                        }
                    elsif talk_to == "Jabal"
                        puts "Hello player"
                    end
                }
                # talk_to = prompt.select("Who would you wish to speak to first? ") do |people|
                #     people.choice "Berwig"
                #     people.choice "Ravenna"
                #     people.choice "Jabal"
                # end




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

