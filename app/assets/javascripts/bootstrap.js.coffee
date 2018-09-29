#jQuery ->
#  $("a[rel*=popover]").popover()
#  $(".tooltip").tooltip()
#  $("a[rel=tooltip]").tooltip()

$ ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "dd-mm-yy"
      dateFormat: "dd-mm-yy"
      altField: $(this).next()