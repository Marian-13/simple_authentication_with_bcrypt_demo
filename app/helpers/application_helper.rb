module ApplicationHelper
  def super_log(object, message = '')
    5.times { puts '************' }
    p object
    p message
    5.times { puts '************' }

    nil
  end
end
