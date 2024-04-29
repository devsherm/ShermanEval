module SortHelper
  def sort_helper(title)
    link_to "#{title.upcase} " + (params[:sort_by] == title ? (params[:sort_order] == "asc" ? "▲" : "▼") : ""), admin_applicants_path(search: params[:search], sort_by: title, sort_order: (params[:sort_by] == title && params[:sort_order] == "asc") ? "desc" : "asc")
  end

  def search_helper
    admin_applicants_path(search: params[:search], sort_order: params[:sort_order], sort_by: params[:sort_by])
  end
end
