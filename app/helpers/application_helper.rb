module ApplicationHelper
  include Pagy::Frontend

  def tailwind_pagy_nav(pagy)
    content_tag(:nav, class: 'flex items-center justify-between') do
      content_tag(:div, class: 'flex') do
        html = ''
        if pagy.prev
          html << link_to('Previous', pagy_url_for(pagy, pagy.prev), class: 'px-3 py-1 border border-indigo-500 rounded-md text-indigo-600 font-medium hover:bg-indigo-100')
        end
        (1..pagy.pages).each do |item|
          classes = item == pagy.page ? 'px-3 py-1 border border-indigo-500 rounded-md text-indigo-600 font-medium hover:bg-indigo-100' : 'px-3 py-1 border border-transparent text-gray-500 font-medium hover:text-gray-700 hover:bg-gray-50'
          html << link_to(item, pagy_url_for(pagy, item), class: classes)
        end
        html.html_safe
      end
    end
  end

  def nav_link_classes(path)
    classes = "inline-flex items-center px-1 pt-1 text-sm font-medium text-gray-500 hover:border-gray-300 hover:text-gray-700"
    current_path = request.path
    if current_path == path || current_path.start_with?("#{path}/")
      classes << " border-b-2 border-indigo-500 text-gray-900"
    else
      classes << " border-b-2 border-transparent"
    end
    classes
  end
end
