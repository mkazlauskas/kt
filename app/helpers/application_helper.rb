module ApplicationHelper
  def format_error_message(errors)
    "The form contains #{pluralize(errors.count, "error")}: #{errors.full_messages.join(', ')}"
  end  
  
  def flash_class(level)
    case level
    when :notice then "info"
    when :error then "error"
    when :alert then "warning"
    end
  end
end