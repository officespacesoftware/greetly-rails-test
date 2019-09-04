module ApplicationHelper
  def sortable(column)
    title = column.titleize
    direction = asc_or_desc(column, params)
    arrow = arrow_direction(params)
    link_to title + arrow, :sort => column, :direction => direction
  end

  private
  def asc_or_desc(column, params)
    (column == params[:sort] && params[:direction] == "desc") ? "asc" : "desc"
  end

  def arrow_direction(params)
    if params[:direction]
      params[:direction] == "asc" ? "↓" : "↑"
    else
      "↓"
    end
  end
end
