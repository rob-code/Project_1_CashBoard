require_relative('../db/sql_runner.rb')


class User

  attr_accessor :first_name, :second_name, :monthly_budget
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
    @monthly_budget = options['monthly_budget'].to_f
  end

def save
sql = "INSERT INTO users (first_name, second_name, monthly_budget) VALUES ('#{@first_name}', '#{@second_name}',#{@monthly_budget}) RETURNING id"
user = SqlRunner.run(sql).first
@id = user['id'].to_i

end

def self.delete_all
  sql = "DELETE FROM users"
  SqlRunner.run(sql)
end




end