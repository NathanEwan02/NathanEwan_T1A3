
class Character
    attr_accessor :name, :race, :char_type

    @@character_array = []

    def initialize(name, race, char_type)
        @name = name
        @race = race
        @char_type = char_type
        @prompt = TTY::Prompt.new
    end

    
    def self.setup
        prompt = TTY::Prompt.new
        divide = "="*100

        puts divide
        puts "Character Creator"
        puts divide

        name = prompt.ask("What is your character's name?")
        puts divide

        @@character_array.append(name)

        race = prompt.select("Select a character race.") do |options|
            options.choice "Human"
            options.choice "Elf"
            options.choice "Dwarf"
            options.choice "Ogre"
        end
        puts divide

        if race == "Human"
            @@character_array.append("Human")
        elsif race == "Elf"
            @@character_array.append("Elf")
        elsif race == "Dwarf"
            @@character_array.append("Dwarf")
        elsif race == "Orge"
            @@character_array.append("Ogre")
        end

        character_type = prompt.select("Select a character type.") do |types|
            types.choice "Warrior"
            types.choice "Mage"
            types.choice "Paladin"
        end
        puts divide

        if character_type == "Warrior"
            @@character_array.append("Warrior")
        elsif character_type == "Mage"
            @@character_array.append("Mage")
        elsif character_type == "Paladin"
            @@character_array.append("Paladin")
        end
    end

    def self.get_char_array(array)
        for items in @@character_array
            array.append(items)
        end
    end 
end