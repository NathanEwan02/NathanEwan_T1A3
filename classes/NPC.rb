class NPC 
    attr_accessor :name, :introduction, :yes, :no

    def initialize(name, introduction, yes, no)
        @name = name
        @introduction = introduction
        @yes = yes
        @no = no
    end

    def start_conversation()
        prompt
        num_inputs.to_i

        choice = prompt.select(text) do |items|
        items.per_page num_inputs
        items.choices options
    end

    end


    
end