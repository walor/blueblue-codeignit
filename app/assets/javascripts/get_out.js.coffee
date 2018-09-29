window.GetOut =
  Init: ->
    @DropDownDynamic()

  DropDownDynamic: ->
    $("select.product_out").on "change", ->
      product_id = $(@).val()
      ware_house_id = $('#ware_house').data('ware_house')
      row_current = $(@).closest("tr")
      url = "/product_by_ware_house?product_id=#{product_id}&ware_house_id=#{ware_house_id}"
      $.ajax
        dataType: "json"
        cache: false
        url: url
        timeout: 2000
        error: (XMLHttpRequest, errorTextStatus, error) ->
          alert "Failed to submit : #{errorTextStatus} ; #{error}"
        success: (data) ->
          row_current.find(".quantity_product").val(data.current_stock)
          row_current.find(".stock_product").text(data.current_stock)
          a = row_current.find(".price_unit").find('input')
          console.log a
          console.log data.avg_price
          row_current.find(".price_unit").find('input').val(data.avg_price)

$ ->
  GetOut.Init()