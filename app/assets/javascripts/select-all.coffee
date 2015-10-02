$(document).ready ->

    numberOfChecked = -> $('.checkme:checked').length

    totalNumberOfCheckboxes = -> $('.checkme').length

    $('#selectall').on 'click', ->
        if @checked
            $(':checkbox').each ->
                @checked = true
        else
            $(':checkbox').each ->
                @checked = false

    $(':checkbox').on 'click', ->
        if numberOfChecked() is totalNumberOfCheckboxes()
            $('#selectall').prop('checked', true)
        else
            $('#selectall').prop('checked', false)
