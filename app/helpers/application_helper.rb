module ApplicationHelper
    def format_status(status)
        if status == "active"
          '<span class="bg-blue-100 text-blue-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded">Active</span>'.html_safe
        elsif status == "deleted"
        '<span class="bg-red-200 text-gray text-xs font-medium me-2 px-2.5 py-0.5 rounded">Deleted</span>'.html_safe
        end
      end
end
