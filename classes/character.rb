class Character
    attr_accessor :name, :race, :char_type

    def initialize(name, race, char_type)
        @name = name
        @race = race
        @char_type = char_type
        @prompt = TTY::Prompt.new
    end

    def character_setup
        divide = "="*100
        puts divide
        puts "Character Creator"
        puts divide
        @prompt.ask("What is your characters name?", )
    end


end