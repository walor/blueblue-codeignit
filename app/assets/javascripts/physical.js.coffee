$ ->
  $("#new_count").on "click", ->
    $('#table_physical').find("input[type='number']").each ->
      $(@).val('0.0')