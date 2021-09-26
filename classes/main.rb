require "tty-prompt"
require_relative "character"


class MainMenu
    def initialize()
        @prompt = TTY::Prompt.new
    end 

    def display_menu
        array = []
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
            new_game 
        elsif choice == "Options"
            options
        elsif choice == "Exit"
        
        end
    end 


    def new_game()
        divide = "="*100
        puts divide
        puts "Character Creator"
        puts divide
        @prompt.ask("What is your character's name?")
    end

    def options

    end

    def exit_game


    end



end



menu = MainMenu.new
menu.display_menu



