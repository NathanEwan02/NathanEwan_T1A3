# class Area
#     @name = "John and Pauls Traveller's Inn"
#     @people_in_it = [new Person("John"), new Person("Paul")]
#     @things_to_do = [
#         {
#             name: "Delapidated Shrine", output: "An old shrine"
#         }, {
#             name: "Cot", output: "An unkept bed"
#         }]

#     def what_is_around
#         @things_to_do.each { |thing|
#             puts thing[:name]
#         }
#     end

#     def interact_with(index)
#         puts @things_to_do[index][:output]
#     end

#     def talk_to_characters
#         prompt = TTY::Prompt.new
#         list_of_people = @people_in_it.each_with_index.map { |npc, index| {name: npc.name, value: index }
#         # ["John", "Paul"]
#         index = prompt.select("Who would you wish to speak to first?", list_of_people)
#         @people_in_it[index].start_conversation
#         # yield
#         # block.call(talk_to)
#     end
# end

# class Person
#     @name = "john"
#     # @item = RandomlyGenerated
#     # @@introductions = ["", ""]

#     def initialize(name, conversation)
#     end

#     def start_conversation
#         select_option(conversation[:introduction], ["Yes", "No"], prompt, 2) {|choice| 
#             if choice == "Yes"
#                 puts conversation[:yes]
#             else 
#                 puts conversation[:no]
#             end
#         }    
#     end
# end

# new Person("John", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" })
# new Person("John", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" })
# new Person("John", {introduction: "Well hello there traveler! May I ask your help?", :yes: "great here is your quest.....", no: "thats a shame, have a good day" })

# class Monster < NPC
# end

# class Friendly < NPC
#     def start_conversation
#         # puts @@introductions.sample
#         puts "Hello you"    
#     end
# end