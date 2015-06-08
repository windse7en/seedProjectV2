root = exports ? this
root.search_results = []
root.current_status = {
    choosen_search_result: "",
}


send_ajax_request = ($url, $data, $callback) ->
    $.ajax({
        url: $url,
        type: 'GET',
        dataType: 'json',
        data: $data,
        success: (data) -> 
            # console.log(data)
            $callback(data) if $callback
        error: () -> alert('Something wrong.')
    })

autocomplete_update_lable = (event, ui, id, value)->
    event.preventDefault()
    $("#"+id).val(ui.item.label)
    root.current_status[value] = ui.item.value



$("#top_search").autocomplete({
    source: (request, response) ->
        send_ajax_request('/home/search_anything', {'top_search': request.term}, (data)->
            root.search_results = data
            response( $.map( root.search_results, (item) ->
                {
                    label: item.label,
                    value: item.value
                }
            ))
        )
    , select: (event, ui)->
        autocomplete_update_lable(event, ui, 'top_search', 'choosen_search_result')
    , focus: (event, ui)->
        autocomplete_update_lable(event, ui, 'top_search', 'choosen_search_result')
    #, appendTo: "#modal-content"
})
