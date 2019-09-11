$(function() {
  sortByDueDate();
})

const sortByDueDate = () => {
  $('#sort-due-date').on('click', function(e) {
    e.preventDefault();

    let listId = $(this).attr('data_id')
    // Send get request for all tasks
    $.getJSON('/lists/' + listId + '/tasks', function(data) {

      // Clear table of tasks to fill in new sorted tasks
      let tasksTable = $('#tasks-table')
      tasksTable.empty()

      let tasks = data
      // Sort tasks by due date
      let sortedTasks = tasks.sort((a, b) => {
        // parse dates into milliseconds for an accurate sort
        let dataA = Date.parse(a.due_date)
        let dataB = Date.parse(b.due_date)
        // sort due_dates with oldest at the top
        return dataA - dataB
      })
      // console.log(sortedTasks)

      // Take sorted tasks and create new table
      sortedTasks.forEach(task => {
        let sortedByDueDate = `
          <tr>
            <td class="h4">${task.name}</td>
            <td class="h4">${task.due_date}</td>
            <td class="h4">${task.complete}</td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}">Show</a></td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}/edit">Edit</a></td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Destroy</a></td>
          </tr>
        `
        tasksTable.append(sortedByDueDate);
      });
    })
  })
}
