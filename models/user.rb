require_relative('../db/sql_runner.rb')


class User

  attr_accessor :first_name, :second_name
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @second_name = options['second_name']
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

  def self.get_many(sql)
    users = SqlRunner.run(sql)
    result = users.map {|user| User.new(user)}
    return result
  end


end