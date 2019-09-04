module ApplicationHelper
  def sortable(column)
    title = column.titleize
    direction = (column == params[:sort] && params[:direction] == "desc") ? "asc" : "desc"
    if params[:direction]
      arrow = direction == "asc" ? "↑" : "↓"
    else
      arrow = "↓"
    end
    link_to title + arrow, :sort => column, :direction => direction
  end
end
