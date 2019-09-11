$(function() {
  sortByDueDate();
})

const sortByDueDate = () => {
  $('#sort-due-date').on('click', function(e) {
    e.preventDefault();

    let listId = $(this).attr('data_id')
    // console.log(listId)
    $.getJSON('/lists/' + listId + '/tasks', function(data) {

      // Clear table of tasks to fill in new sorted tasks
      let tasksTable = $('#tasks-table')
      tasksTable.empty()

      let tasks = data

      // Sort tasks by due date
      let sortedTasks = tasks.sort((a, b) => {
        // console.log(a.due_date - b.due_date)
        let dataA = Date.parse(a.due_date)
        let dataB = Date.parse(b.due_date)
        return dataA - dataB
      })
      console.log(sortedTasks)

      // Take sorted tasks and create new table
      sortedTasks.forEach(task => {
        let sortByDueDate = `
          <tr>
            <td class="h4">${task.name}</td>
            <td class="h4">${task.due_date}</td>
            <td class="h4">${task.complete}</td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}">Show</a></td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}/edit">Edit</a></td>
            <td class="h4"><a href="/lists/${listId}/tasks/${task.id}" data-confirm="Are you sure?" data-method="delete" rel="nofollow">Destroy</a></td>
          </tr>
        `
        tasksTable.append(sortByDueDate);
      });
    })
  })
}
