module SortHelper
  def sort_helper(title)
    link_to "#{title.upcase} " + (params[:sort_by] == title ? (params[:sort_order] == "asc" ? "▲" : "▼") : ""), admin_applicants_path(sort_by: title, sort_order: (params[:sort_by] == title && params[:sort_order] == "asc") ? "desc" : "asc")
  end
end
