require_relative 'view'
require_relative 'model'

class Controller
  include View

  def initialize
    send_welcome
    @model = Model.new
    generate_solution
  end

  def generate_solution
    # get_names_from_model
    # send_names_to_view
    # collect_prior_pairs
    get_groups_from_model
    send_groups_to_view
  end

  # def collect_prior_pairs
  #   while true
  #     @pair = request_duo_pair
  #     return if pair[0] = ''
  #     (send_names_to_view && redo) if pair[0] == 'list'
  #     if pair.size = 2
  #       send_problem_with_pair unless send_prior_pair_to_model
  #     else
  #       send_problem_with_pair
  #     end
  #   end
  # end

  private
  attr_reader :pair, :model

# model methods
  # def get_names_from_model
  #   @names = model.send_list_of_names
  # end

  def get_groups_from_model
    @groups = model.send_groups
  end

  # def send_prior_pair_to_model
  #   model.receive_prior(pair)
  # end

# view methods
  def send_welcome
    View.welcome
  end

  # def send_names_to_view
  #   View.display_names(@names)
  # end

  # def request_duo_pair
  #   View.get_duo_pair
  # end

  # def send_problem_with_pair
  #   View.problem_with_pair
  # end

  def send_groups_to_view
    View.display_groups(@groups)
  end
end
