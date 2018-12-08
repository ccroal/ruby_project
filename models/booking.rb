require_relative('../db/sql_runner.rb')
require_relative('./member.rb')
require_relative('./session.rb')

class Booking

  def initialize(options)
    @member_id = options['member_id'].to_i()
    @session_id = options['session_id'].to_i()
  end

  def save()
    sql = "INSERT INTO bookings (member_id, session_id)
    VALUES ($1, $2) RETURNING id"
    values = [@member_id, @session_id]
    booking = SqlRunner.run(sql, values).first
    @id = booking['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    bookings = SqlRunner.run(sql)
    result = bookings.map {|booking| Booking.new(booking)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
