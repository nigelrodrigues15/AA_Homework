require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
    INSERT INTO
    plays (title, year, playwright_id)
    VALUES
    (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
    UPDATE
    plays
    SET
    title = ?, year = ?, playwright_id = ?
    WHERE
    id = ?
    SQL
  end

  def self.find_by_title(title)
    raise "#{title} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title)
    SELECT
    *
    FROM
    plays
    WHERE
    title = ?
    SQL
  end

  def self.find_by_playwright(name)

  end

end

class Playwright

  attr_accessor :name, :birth_year

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_name(name)
    raise "#{name} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name)
    SELECT
    *
    FROM
    playwrights
    WHERE
    name = ?
    SQL
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
    INSERT INTO
    playwrights (name, birth_year)
    VALUES
    (?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
    UPDATE
    playwrights
    SET
    name = ?, birth_year = ?
    WHERE
    id = ?
    SQL
  end

  def get_plays
    PlayDBConnection.instance.execute(<<-SQL, @id)
    SELECT
    plays.title
    FROM
    plays
    JOIN
    playwrights
    ON
    plays.playwright_id = playwrights.id
    WHERE
    plays.playwright_id = ?
    SQL
  end

end
