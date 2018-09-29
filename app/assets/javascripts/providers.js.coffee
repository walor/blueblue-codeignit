$(document).ready ->
  div_natural_person = $("#natural_person")
  radio_type_provider_1 = $("#provider_type_provider_1")
  radio_type_provider_2 = $("#provider_type_provider_2")

  div_natural_person.hide() if radio_type_provider_1.is(":checked")
  div_natural_person.show() if radio_type_provider_2.is(":checked")

  radio_type_provider_1.on "click", ->
    div_natural_person.hide()
    $("#provider_first_name").val("")
    $("#provider_last_name").val("")
    $("#provider_maiden_name").val("")

  radio_type_provider_2.on "click", ->
    div_natural_person.show()
