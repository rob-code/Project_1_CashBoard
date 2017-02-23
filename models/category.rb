require_relative('../db/sql_runner.rb')

class Category

  attr_accessor :category_name
  attr_reader :id

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @category_name = options['category_name']
  end

  def save
    sql = "INSERT INTO categories (category_name) VALUES ('#{@category_name}') RETURNING id" 
    category = SqlRunner.run(sql).first
    @id = category['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM categories"
    SqlRunner.run(sql)
  end

  def self.all
  sql = "SELECT * FROM categories"
  return self.get_many(sql)
  end

  def self.return_by_id(id_required)
  sql = "SELECT * FROM categories WHERE id = #{id_required}"
  return SqlRunner.run(sql)
  end


  def self.get_many(sql)
    categories = SqlRunner.run(sql)
    result = categories.map {|category| Category.new(category)}
    return result
  end

end