# adding gems to run
require 'tty-prompt'
require 'csv'
require 'artii'
require 'rainbow'

# Adding paths to classes and error handling folders
require_relative "errors/main_exceptions"
require_relative "classes/character"
require_relative "classes/map"
require_relative "classes/NPC"

#checking for file
begin
    CSV.read("player.csv")
rescue Errno::ENOENT
    puts "File not found"
end

arg_choice = false

#Establishing command line arguments
case ARGV[0]
when '-h' || '--help'
    puts Rainbow("Welcome to the help screen, your options are as follows:").cyan
    puts Rainbow("Type '-n' or '--new' after 'ruby main.rb' to start a new game and skip the main menu").cyan
    puts Rainbow("Type '-g' or '--guide' after 'ruby main.rb' to access the instructions on how to play").cyan
when '-n' || '--new'
    main_menu = true
    arg_choice = true
when '-g' || '--guide'
    puts Rainbow("The Goal of the game is to find the King's 'Holy sandwich', to do this you need to talk to NPC's and listen to their hints").cyan
    puts Rainbow("You might need to travel to a different location using the game menu, and map menu.").cyan
    puts Rainbow("Once you have found the sandwich the game will end.").cyan
else 
    main_menu = true
end

# Establishing gems in varibales
prompt = TTY::Prompt.new
a = Artii::Base.new

divide = "="*100

#Initialising instances of NPC class
berwig = NPC.new("Berwig", "Well hello there traveler! Do you need some help finding the 'Holy Sandwich'?", 
    "Alright then, make your way over to Jabal he'll explain the rest", "That's a shame, fair well")

ravenna = NPC.new("Ravenna", "Hi, you said you were sent looking for the sandwich?", 
    "Sorry, but I don't know anything about that maybe go talk to sheriff Berwig", "Oh ok, never mind then")

jabal = NPC.new("Jabal", "What can I help you with?", "Ah yes of course, you must make your way over to Saxondale, good luck", 
    "Very well")

marita = NPC.new("Marita", "Well hello, are by chance looking for the 'Holy Sandwich'? ", 
    "Go to Nevan he'll have it, just make sure you tell him Marita sent you", "Well then, I best be on my way")

nevan = NPC.new("Nevan", "So you say you're looking for the 'Holy Sandwich'?", "I don't have it go away!", "Well be gone then")

#Initialising instances of Map class
fernsworth = Map.new("Fernsworth", [berwig, ravenna, jabal])
saxondale = Map.new("Saxondale", [marita, nevan])

current_location = fernsworth.name
unvisited_location = saxondale.name

character_array = []
error = false

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

#puts a.asciify('Holy Sandwich')
#main_menu = true

while main_menu == true
    puts a.asciify('Holy Sandwich')
    create_title("Main Menu", divide)
    menu_choice = ''
    
    if arg_choice == false
        menu_choice = prompt.select("What would you like to do?") do |item|
            item.choice "New Game"
            item.choice "Options"
            item.choice "Exit"
        end
    end
    puts divide

    if menu_choice == "New Game" || arg_choice == true

        select_option("Would you like to use an old character?", ["Yes", "No"], prompt, 2) {|choice|
            if choice == "Yes"

                csv = CSV.read("player.csv", headers: true)
                csv.each_with_index {|row, index|
                    puts "#{index}: #{row[0]}"
                }

                character_name = prompt.ask("Which character would you like to choose? (name)",)
                
                char = csv.find {|row| row[0] == character_name}

                if char == nil
                    puts "Error, no character by this name"
                    error = true
                elsif char != nil
                    player = Character.new(char[0], char[1], char[2])
                end
            
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

        if error == true
            game_loop = false
        end
        
        while game_loop == true

            if current_location == fernsworth.name
                create_title(fernsworth.name, divide)
                puts Rainbow("You have been tasked by the king to find the Holy Sandwich!").cyan
            else 
                create_title(saxondale.name, divide)
                puts Rainbow("You have been tasked by the king to find the Holy Sandwich!").cyan
            end
        
            choice = prompt.select("Welcome to #{current_location} #{player.name}, what would you like to do?") do |options|
                options.choice "Talk to NPCs"
                options.choice "Open Game Menu"
            end 
            puts divide 

            if choice == "Talk to NPCs" and current_location == fernsworth.name
                talk_to_npcs([berwig.name, ravenna.name, jabal.name], divide) {|talk_to| 
                    if talk_to == berwig.name
                        berwig.give_choices("Yes", "No")
                    elsif talk_to == ravenna.name
                        ravenna.give_choices("Yes", "No")
                    elsif talk_to == jabal.name
                        jabal.give_choices("Finding the Holy Sandwich", "Nevermind")
                    end
                }
            
            elsif choice == "Talk to NPCs" and current_location == saxondale.name
                talk_to_npcs([marita.name, nevan.name], divide) { |talk_to|
                    if talk_to == marita.name
                        marita.give_choices("Yes", "No")
                    elsif talk_to == nevan.name
                        select_option(nevan.introduction, ["Yes", "No", "Marita sent me"], prompt, 2) { |choice|
                            if choice == "Yes"
                                puts nevan.response_1
                            elsif choice == "No"
                                puts nevan.response_2
                            else 
                                puts "Ah good, here you go!"
                                game_loop = false
                            end
                        }
                    end

                }


            elsif choice == "Open Game Menu"

                game_menu = true
                while game_menu == true

                    create_title("Game Menu", divide)
                    select_option("Welcome #{player.name}, what would you like to do?", ["View Map", "Character Options", "Back", "Exit Game"], prompt, 4) { |choice|
                        if choice == "View Map"
                            create_title("Map", divide)
                            select_option("Select a location", ["Fernsworth", "Saxondale", "Back"], prompt, 3) { |choice|
                                if choice == current_location
                                    puts "You are already here"
                                elsif choice == unvisited_location
                                    puts "Welcome to Saxondale"
                                    current_location, unvisited_location = unvisited_location, current_location
                                else 
                                end
                            }
                        elsif choice == "Character Options"
                            select_option("Would you like to change your character's name?", ["Yes", "No"], prompt, 2) {|choice|
                                if choice == "Yes"
                                    puts "Enter a new name: "
                                    new_name = gets.chomp.to_s
                                    player.name = new_name
                                elsif choice == "No"
                                    game_menu = false
                                end
                            }
                        elsif choice == "Back"
                            game_menu = false

                        else 
                            game_menu = false
                            game_loop = false
                        end
                    }
                end
            end
        end

    elsif menu_choice == "Options"
        puts "Type '-h' or '--help' after 'ruby main.rb' to access more information"
    elsif menu_choice == "Exit"
        main_menu = false
    end
    
end 

