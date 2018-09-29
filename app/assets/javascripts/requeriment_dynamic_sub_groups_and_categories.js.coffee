RequirementForm =
  Init: ->
    @ChangeRequerimentType()
    @DropDownDynamic()

  AjaxSendSelect: (target, url, param_id, row_current = null)->
    row_current = $('tbody#requeriment_items') if row_current == null
    if param_id is ""
      # if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      row_current.find("#{target} option").remove()
      row = "<option value=\"" + "" + "\">" + "" + "</option>"
      $(row).appendTo row_current.find(target)
    else
      $.ajax
        dataType: "json"
        cache: false
        url: url
        timeout: 2000
        error: (XMLHttpRequest, errorTextStatus, error) ->
          alert "Failed to submit : #{errorTextStatus} ; #{error}"
        success: (data) ->
          row_current.find("#{target} option").remove() # Clear all options from sub category select
          #put in a empty default line
          row = "<option value=''>- Seleccione una opcion - </option>"
          $(row).appendTo row_current.find(target)
          # Fill sub category select
          $.each data, (i, j) ->
            row = "<option value='#{j.id}'> #{j.description} </option>"
            $(row).appendTo row_current.find(target)


  DropDownDynamic: ->
    $("select.filter_group").on "change", ->
      group_id = $(@).val()
      target = "select.filter_sub_group"
      url = "/dynamic_sub_groups?group_id=#{group_id}"
      row_current = $(@).closest("tr")
      RequirementForm.AjaxSendSelect(target, url, group_id, row_current)
      row_current.find("select.filter_category option").remove()
      row_current.find("select.filter_product option").remove()

    $("select.filter_sub_group").on "change", ->
      sub_group_id = $(@).val()
      target = "select.filter_category"
      url = "/dynamic_categories?sub_group_id=#{sub_group_id}"
      row_current = $(@).closest("tr")
      RequirementForm.AjaxSendSelect(target, url, sub_group_id, row_current)
      row_current.find("select.filter_product option").remove()

    $("select.filter_category").on "change", ->
      category_id = $(@).val()
      target = "select.filter_product"
      url = "/dynamic_products?category_id=#{category_id}"
      row_current = $(@).closest("tr")
      RequirementForm.AjaxSendSelect(target, url, category_id, row_current)

  ChangeRequerimentType: ->
    $('.requeriment_type_requeriment').on 'click', '.requeriment_type', (event) ->
      requirement_type = +$(@).val()
      $('#requeriment_ware_house_id option').attr('selected', false)
      if requirement_type == 2
        $(".requeriment_ware_house").closest(".row-fluid").hide()
      else
        $(".requeriment_ware_house").closest(".row-fluid").show()
      target = "select.filter_group"
      url = "/dynamic_groups_by_type?type=#{requirement_type}"
      RequirementForm.AjaxSendSelect(target, url, requirement_type)
      #reset
      $('select.filter_sub_group').find('option').remove()
      $('select.filter_category').find('option').remove()
      $('select.filter_product').find('option').remove()

$ ->
  RequirementForm.Init()

  $(document).on "nested:fieldAdded", (event) ->
    if $("input[name='requeriment[type_requeriment]']:checked").val() is undefined
      requirement_type =  1
    else
      requirement_type =  $("input[name='requeriment[type_requeriment]']:checked").val()
    field = event.field
    target = field.find("select.filter_group")
    row_current = target.closest("tr")
    url = "/dynamic_groups_by_type?type=#{requirement_type}"
    RequirementForm.DropDownDynamic()
    GetOut.DropDownDynamic()
    if requirement_type is ""
      # if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      row_current.find("#{target} option").remove()
      row = "<option value=''>- Seleccione una opcion - </option>"
      $(row).appendTo row_current.find(target)
    else
      $.ajax
        dataType: "json"
        cache: false
        url: url
        timeout: 2000
        error: (XMLHttpRequest, errorTextStatus, error) ->
          alert "Failed to submit : #{errorTextStatus} ; #{error}"
        success: (data) ->
          target.find('option').remove()# Clear all options from sub category select
          #put in a empty default line
          row = "<option value=''>- Seleccione una opcion - </option>"
          $(row).appendTo target
          # Fill sub category select
          $.each data, (i, j) ->
            row = "<option value='#{j.id}'> #{j.description} </option>"
            $(row).appendTo target