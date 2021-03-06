class Model

  def initialize
    get_list_of_names
    build_solution_array
    build_possible_partners_for_each_name
    @prior_pairs = [[:ovi, :shawn], [:amaar, :brian], [:abe, :bernice], [:fatma, :jon], [:eran, :greg], [:bill, :michael], [:nilt, :tal], [:trevor, :walter], [:karla, :mia], [:karla, :natasha], [:mia, :natasha], [:fatma, :greg], [:mia, :michael], [:amaar, :bernice], [:nilt, :ovi], [:eran, :jon], [:bill, :karla], [:bill, :natasha], [:shawn, :trevor], [:tal, :walter], [:eran, :fatma], [:nilt, :shawn], [:karla, :michael], [:michael, :natasha], [:bernice, :brian], [:greg, :jon], [:bill, :mia], [:tal, :trevor], [:ovi, :walter], [:bill, :fatma], [:abe, :tal], [:jon, :shawn], [:brian, :michael], [:mia, :trevor], [:amaar, :ovi], [:bernice, :karla], [:eran, :natasha], [:greg, :walter], [:nilt, :walter], [:greg, :nilt], [:fatma, :tal], [:jon, :michael], [:karla, :shawn], [:bernice, :mia], [:eran, :trevor], [:amaar, :walter], [:brian, :natasha], [:bill, :ovi], [:abe, :bill], [:abe, :ovi], [:mia, :tal], [:amaar, :greg], [:abe, :shawn], [:bill, :shawn], [:brian, :eran], [:karla, :ovi], [:jon, :natasha], [:bernice, :fatma], [:michael, :trevor], [:amaar, :nilt], [:bernice, :tal], [:fatma, :mia], [:abe, :karla]]
  end

  def get_list_of_names
    @list = [:jon, :ovi, :abe, :amaar, :brian, :bernice, :eran, :fatma, :karla, :mia, :greg, :natasha, :nilt, :tal, :shawn, :bill, :trevor, :walter, :michael]
  end

  def build_solution_array
    @blank_solution = Array.new << Array.new(5,:open) << Array.new(4,:open) << Array.new(4,:open) << Array.new(6,:open)
  end

  def build_possible_partners_for_each_name
    @names = Hash.new
    @list.each{|name| @names[name] = @list - [name]}
    @names[:open] = [] + @list
  end

  def calculate_groups
    delete_prior_pairs_from_possibles
    @list.delete(:jon)
    find_recursive_solution([:jon] + @list.shuffle, @blank_solution)
  end

  def delete_prior_pairs_from_possibles
    @prior_pairs.each do |pair|
      @names[pair[0]].delete(pair[1])
      @names[pair[1]].delete(pair[0])
    end
  end

  def find_recursive_solution(working_list, working_solution)
    if within_constraints?(working_solution)
      return working_solution unless working_solution.flatten.include?(:open)
    end
    working_list.each do |name|
      replaced = false
      working_solution.each_with_index do |team,index|
        if team.include?(:open) && !replaced
          working_solution[index][team.find_index(:open)] = name
            if within_constraints?(working_solution)
              replaced = true
              p working_solution
            else
              working_solution[index][team.find_index(name)] = :open
            end
        end
      end
    # p working_solution
      return find_recursive_solution(working_list - [name], working_solution)
    end
  end

  def within_constraints?(possible_solution)
    possible_solution.each do |group|
      allowed_conflicts = (group.size == 5) ? 1 : group.size - 3
      group_members = [] + group
      group_members.delete(:open)
      group_members.each do |member|
        (group - names[member] - [:open]).size <= allowed_conflicts
        return false unless (group_members - names[member]).size <= allowed_conflicts
      end
    end
    return true
  end

#methods communicating with controller
  # def send_list_of_names
  #   @list
  # end

  # def receive_prior(pair)#(array of two names)
  #   return false unless (pair - names).size = 0
  #   @prior_pairs << pair
  # end

  def send_groups
    p calculate_groups
  end

  private
  attr_reader :names
  attr_accessor :groups

end
=begin

[[:michael, :ovi, :eran, :bernice, :open], [:bill, :brian, :walter, :jon], [:natasha, :amaar, :shawn, :fatma], [:nilt, :abe, :karla, :mia, :greg, :trevor]]
[[:amaar, :shawn, :eran, :michael, :tal], [:bernice, :jon, :trevor, :bill], [:karla, :greg, :brian, :open], [:mia, :abe, :nilt, :walter, :fatma, :natasha]]
natasha
bernice
greg
ovi
trevor

Team 1:
amaar
karla
tal
eran

Team 2:
brian
bill
walter
jon

Team 3:
fatma
mia
shawn
nilt

Team 0:
jon
bill
nilt
trevor
bernice

Team 1:
shawn
eran
mia
walter

Team 2:
abe
michael
amaar
fatma

Team 3:
natasha
ovi
karla
greg
tal
brian



=end
