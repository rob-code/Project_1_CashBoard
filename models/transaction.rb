require_relative('../db/sql_runner.rb')

class Transaction

  attr_accessor :merchant_name, :amount, :category_id
  attr_reader :id, :user_id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @merchant_name = options['merchant_name']
    @amount = options['amount'].to_f
    @category_id = options['category_id'].to_i
    @user_id = options['user_id'].to_i
  end

  def self.all_for_user(user_id)
    sql = "SELECT * FROM transactions WHERE user_id = #{user_id}"
    return self.get_many(sql)
  end


  def self.subcategories(user_id, cat_id)
    sql = "SELECT * FROM transactions WHERE user_id = #{user_id} AND category_id = #{cat_id}"
    return self.get_many(sql)
  end

  def save()
    sql = "INSERT INTO transactions (merchant_name, amount, category_id, user_id) VALUES ('#{@merchant_name}', #{@amount}, #{@category_id}, #{@user_id})RETURNING id"
    transaction = SqlRunner.run(sql).first
    @id = transaction['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM transactions"
    return self.get_many(sql)
  end

  def self.return_by_id(id_required)
    sql = "SELECT * FROM transactions WHERE id = #{id_required}"
    transaction = SqlRunner.run(sql)
    result = Transaction.new(transaction.first)
    return result
  end

  def update()
    sql = "UPDATE transactions SET
    merchant_name = '#{@merchant_name}',
    amount = '#{@amount}',
    category_id = '#{@category_id}',
    user_id = '#{@user_id}'
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_by_id(id_required)
    sql = "DELETE FROM transactions WHERE id = #{id_required}"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    transactions = SqlRunner.run(sql)
    result = transactions.map {|transaction| Transaction.new(transaction)}
    return result
  end


end

