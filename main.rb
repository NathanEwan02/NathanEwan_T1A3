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

def talk_to_npcs(list_of_people, divide, &block)
    prompt = TTY::Prompt.new
    talk_to = prompt.select("Who would you wish to speak to first?", list_of_people)
    puts divide

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

                csv = CSV.read("player.csv", headers: true)
                csv.each_with_index {|row, index|
                    puts "#{index}: #{row[0]}"
                }

                character_name = prompt.ask("Which character would you like to choose? (name)",)
                
                char = csv.find {|row| row[0] == character_name}
                
                player = Character.new(char[0], char[1], char[2])
            
            else 
                Character.setup(divide, create_title("Character Creator", divide))
                Character.get_char_array(character_array)

                name = character_array[0]
                race = character_array[1]
                char_type = character_array[2]

                CSV.open("player.csv", "a+", headers: true) do |csv|
                    csv << [name, race, char_type]
                end

                player = Character.new(character_array[0], character_array[1], character_array[2])
            end
        }

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
                talk_to_npcs([berwig.name, ravenna.name, jabal.name], divide) {|talk_to| 
                    if talk_to == berwig.name
                        select_option("Well hello there traveler! Do you need some help finding the 'Holy Sandwich'?", ["Yes", "No"], prompt, 2) {|choice| 
                            if choice == "Yes"
                                puts "Alright then, make your way over to Jabal he'll explain the rest"
                            else 
                                puts "That's a shame, fair well"
                            end
                        }
                    elsif talk_to == ravenna.name
                        select_option("Hi, you said you were sent looking for the sandwich?", ["Yes", "No"], prompt, 2) {|choice| 
                            if choice == "Yes"
                                puts "Sorry, but I don't know anything about that maybe go talk to sheriff Berwig"
                            else 
                                puts "Oh ok, never mind then"
                            end
                        }
                    elsif talk_to == jabal.name
                        select_option("What can I help you with?", ["Finding the Holy Sandwich", "Nevermind"], prompt, 2) { |choice|
                            if choice == "Finding the Holy Sandwich"
                                puts "Ah yes of course, you must make your way over to Saxondale, good luck"
                            else 
                                puts "Very well"
                            end
                        }
                    end
                }

            elsif choice == "Open Game Menu"
                create_title("Game Menu", divide)
                select_option("Welcome #{player.name}, what would you like to do?", ["View Map", "Character Options", "Exit Game"], prompt 3) { |choice|
                    if choice == "View Map"
                        create_title("Map", divide)
                        select_option("Select a location", [])


                    elsif choice == "Character Options"
                        puts ""
                    else 
                        game_loop = false
                }


                #GameMenu.display_game_menu(player)
            end
        end

    elsif choice == "Options"
        puts "opt"
    elsif choice == "Exit"
        main_menu = false
    end
    
end 

