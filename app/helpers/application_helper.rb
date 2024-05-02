module ApplicationHelper
  include Pagy::Frontend
  def format_status(status)
    status_class = case status
    when "active"
      "bg-blue-100 text-blue-800"
    when "deleted"
      "bg-red-100 text-gray"
    when "pending"
      "bg-yellow-100 text-gray"
    when "reviewed"
      "bg-blue-200 text-gray"
    when "rejected"
      "bg-red-200 text-gray"
    when "approved"
      "bg-green-200 text-gray"
    else
      ""
    end

    if status_class.present?
      "<span class='#{status_class} text-xs font-medium me-2 px-2.5 py-0.5 rounded'>#{status.humanize}</span>".html_safe
    else
      status
    end
  end
end