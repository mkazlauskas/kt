module ApplicationHelper
  def format_error_message(errors)
    "The form contains #{pluralize(errors.count, "error")}: #{errors.full_messages.join(', ')}"
  end  
end