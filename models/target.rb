require_relative('../db/sql_runner.rb')

class Target

  attr_accessor :amount, :category_id
  attr_reader :id, :user_id

  def initialize (options)
    @id = options['id'].to_i
    @amount = options['amount'].to_f
    @category_id = options['category_id'].to_i
    @user_id = options['user_id'].to_i
  end

  def save
    sql = "INSERT INTO targets (amount, category_id, user_id) VALUES (#{@amount}, #{@category_id}, #{@user_id}) RETURNING id"
    user = SqlRunner.run(sql).first
    @id = user['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM targets"
    SqlRunner.run(sql)
  end

  def self.all
  sql = "SELECT * FROM targets"
  return self.get_many(sql)
  end


  def self.return_by_id(id_required)
  sql = "SELECT * FROM targets WHERE id = #{id_required}"
  return SqlRunner.run(sql)
  end


  def update()
    sql = "UPDATE targets SET
    amount = #{@amount},
    category_id = #{@category_id},
    user_id = #{user_id}
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end




  def self.delete_by_id(id_required)
    sql = "DELETE FROM targets WHERE id = #{id_required}"
    SqlRunner.run(sql)
  end



  def self.get_many(sql)
    targets = SqlRunner.run(sql)
    result = targets.map {|target| Target.new(target)}
    return result
  end


end