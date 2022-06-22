require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map{|ele| User.new(ele)}
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(find_id)
    lookup_id = QuestionsDatabase.instance.execute(<<-SQL, find_id)
      SELECT * 
      FROM users 
      WHERE id = ?
    SQL
    return nil unless lookup_id.length > 0

    User.new(lookup_id.first)
  end

  def self.find_by_name(first,last)
   lookup_name = QuestionsDatabase.instance.execute(<<-SQL, first, last)
      SELECT * 
      FROM users 
      WHERE fname = ? AND lname = ?
    SQL
    return nil unless lookup_name.length > 0

    User.new(lookup_name.first)
  end
  def authored_question
    # Question.find_by_author
  end
  
  def authored_replies
    #Reply.find_by_user_id
  end

end

class Question
  attr_accessor :fname, :lname
  
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map{|ele| Question.new(ele)}
  end

  def initialize(options)
    @question_id = options['question_id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end

  def self.find_by_id(find_id)
    lookup_id = QuestionsDatabase.instance.execute(<<-SQL, find_id)
      SELECT * 
      FROM questions 
      WHERE question_id = ?
    SQL
    return nil unless lookup_id.length > 0

    Question.new(lookup_id.first)
  end

  def self.find_by_title(find_title)
    lookup_title = QuestionsDatabase.instance.execute(<<-SQL,find_title)
      SELECT * 
      FROM questions 
      WHERE title = ?
    SQL
    return nil unless lookup_title.length > 0

    Question.new(lookup_title.first)
  end

    def self.find_by_author(find_author)
    lookup_author = QuestionsDatabase.instance.execute(<<-SQL,find_author)
      SELECT * 
      FROM questions 
      WHERE author = ?
    SQL
    return nil unless lookup_author.length > 0

    Question.new(lookup_author.first)
  end

  def author
  end

  def replies
    #Reply.find_by_question
  end

end