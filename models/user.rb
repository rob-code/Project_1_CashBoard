require_relative('../db/sql_runner.rb')

class User

  attr_accessor :first_name, :second_name
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
  end

  def transactions
    sql = "SELECT transactions.* FROM 
    transactions WHERE transactions.user_id = #{@id}"
    return Transaction.get_many(sql)
  end

  def total_spend
    sql = "SELECT SUM(transactions.amount) FROM transactions WHERE transactions.user_id = #{@id}"
    total_spend = SqlRunner.run(sql).first
    return total_spend['sum'].to_f
  end

def spend_by_category
sql = "SELECT transactions.category_id, SUM(transactions.amount) FROM transactions WHERE transactions.user_id = #{@id} GROUP BY transactions.category_id"
  totals = SqlRunner.run(sql)
  totals.map do |total|
    puts "#{total['category_id']} and #{total['sum']}"
  end 
end

  def save
    sql = "INSERT INTO users (first_name, second_name) VALUES ('#{@first_name}', '#{@second_name}') RETURNING id"
    user = SqlRunner.run(sql).first
    @id = user['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM users"
    return self.get_many(sql)
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM users WHERE id = #{id_required}"
    return SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE users SET
    first_name = '#{@first_name}',
    second_name = '#{@second_name}'
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id_required)
    sql = "DELETE FROM users WHERE id = #{id_required}"
    SqlRunner.run(sql)
  end


  def self.get_many(sql)
    users = SqlRunner.run(sql)
    result = users.map {|user| User.new(user)}
    return result
  end


end