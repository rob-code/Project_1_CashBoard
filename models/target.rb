require_relative('../db/sql_runner.rb')

class Target

  attr_accessor :target_amount, :category_id
  attr_reader :id, :user_id

  def initialize (options)
    @id = options['id'].to_i
    @target_amount = options['target_amount'].to_f
    @category_id = options['category_id'].to_i
    @user_id = options['user_id'].to_i
  end

  def save
    sql = "INSERT INTO targets (target_amount, category_id, user_id) VALUES (#{@target_amount}, #{@category_id}, #{@user_id}) RETURNING id"
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



  def self.get_many(sql)
    targets = SqlRunner.run(sql)
    result = targets.map {|target| Target.new(target)}
    return result
  end


end