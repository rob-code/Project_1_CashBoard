require_relative('../db/sql_runner.rb')

class Budget

  attr_accessor :total_budget 
  attr_reader :id, :user_id

  def initialize (options)
    @id = options['id'].to_i
    @total_budget = options['total_budget'].to_f
    @user_id = options['user_id'].to_i
  end

  def save
    sql = "INSERT INTO budgets (total_budget, user_id) VALUES (#{@total_budget}, #{@user_id}) RETURNING id"
    user = SqlRunner.run(sql).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM budgets"
    return self.get_many(sql)
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM budgets WHERE id = #{id_required}"
    return SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE budgets SET
    total_budget = #{@total_budget},
    user_id = #{@user_id}
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id_required)
    sql = "DELETE FROM budgets WHERE id = #{id_required}"
    budget = SqlRunner.run(sql)
    result = Budget.new(budget.first)
    return result
  end

  def self.get_many(sql)
    budgets = SqlRunner.run(sql)
    result = budgets.map {|budget| Budget.new(budget)}
    return result
  end

end