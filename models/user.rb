require_relative('../db/sqlrunner.rb')


class User

  attr_accessor :first_name, :second_name, :monthly_budget
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
    @monthly_budget = options['monthly_budget'].to_f
  end




end