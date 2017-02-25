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
    sql = "SELECT categories.name, SUM(transactions.amount) FROM transactions INNER JOIN categories ON categories.id = transactions.category_id WHERE transactions.user_id = #{@id} GROUP BY categories.name;"
    totals = SqlRunner.run(sql)
  # totals.map do |total|
  #   puts "#{total['name']} = #{total['sum']}"
  # end 
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
  user = SqlRunner.run(sql)
  result = User.new(user.first)
  return result
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