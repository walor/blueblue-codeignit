$(document).ready ->
  ware_houses = $("#search_movement_ware_house_id_eq")

  load_combobox = (id, data) ->
    combobox = $(id).attr("disabled", false)
    combobox.children('option').remove()
    combobox.append("<option value=''>- Seleccione producto -</option>")
    combobox.append("<option value=#{item.id}>#{item.description}</option>") for item in data

  ware_houses.on "change", ->
    $.get("/products_by_ware_house", { ware_house_id: this.value })
    .done (data) ->
      load_combobox("#search_product_id_eq", data)