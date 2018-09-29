$(document).ready ->
    groups = $("#search_group_id_eq")
    sub_groups = $("#search_sub_group_id_eq")
    categories = $("#search_category_id_eq")

    sub_groups.attr("disabled", false) if groups.val()
    categories.attr("disabled", false) if sub_groups.val()

    load_combobox = (id, data) ->
      combobox = $(id).attr("disabled", false)
      combobox.children('option:not(:first)').remove()
      combobox.append("<option value=#{item.id}>#{item.description}</option>") for item in data

    groups.on "change", ->
      $.get("/dynamic_sub_groups", { group_id: this.value })
      .done (data) ->
        load_combobox("#search_sub_group_id_eq", data)
        categories.children('option:not(:first)').remove()
        categories.attr("disabled", true)

    sub_groups.on "change", ->
      $.get("/dynamic_categories", { sub_group_id: this.value })
      .done (data) ->
        load_combobox("#search_category_id_eq", data)