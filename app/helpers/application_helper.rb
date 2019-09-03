module ApplicationHelper
  def sortable(column)
    title = column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    title = direction == "asc" ? "#{column.titleize}↑" : "#{column.titleize}↓"
    link_to title, :sort => column, :direction => direction
  end
end
