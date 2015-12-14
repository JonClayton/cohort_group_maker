module View

  def View.welcome
    puts 'Welcome to the Island Foxes group builder.'
    puts
    puts 'This is designed to build groups for a week of pairing that will minimize the number of repeat pairings during the week'
    puts
  end

  # def View.display_names(array_of_names)
  #   puts 'Here are the members.  If you need to see the list again enter "list"'
  #   puts array_of_names
  # end

  # def View.get_duo_pair
  #   puts 'Please enter names of two people who have paired, separated by a space.  If all pairs have been entered, just hit return'
  #   puts 'Pair was: '
  #   gets.chomp #returns array of two names
  # end

  # def View.problem_with_pair
  #   puts 'There was a problem with that pair entry. Try again'
  # end

  def View.display_groups(array_of_groups)
    array_of_groups.each_with_index do |group,index|
      puts "Team #{index}:"
      puts group
      puts
    end
  end

end
