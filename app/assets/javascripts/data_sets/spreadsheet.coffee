$ ->
  if namespace.controller is "data_sets" and namespace.action is "spreadsheet"
    console.log "immm hurrrr"
    ($ '#edit_table_add').click ->
      new_row = '<tr>'
      
      ($ '#editTable tbody tr').eq(0).find('td').each ->
        new_row += '<td><input type="text" class="form-control"/></td>'
          
      new_row += "</tr>"
      
      ($ '#editTable tbody').append new_row
      
    ($ '#edit_table_save').click ->
      
      pull_data = []
      
      ($ '#editTable tbody tr').each (row_index, row) ->
        values = []
        
        ($ row).find('td').each (col_index, col) ->
          console.log "gettin data"