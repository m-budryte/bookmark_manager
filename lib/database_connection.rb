# frozen_string_literal: true

class DatabaseConnection
  def self.setup(database)
    @connection = PG.connect(dbname: database)
  end

  class << self
    attr_reader :connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end
end
