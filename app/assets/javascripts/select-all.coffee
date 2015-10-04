$(document).ready ->

    numberOfChecked = -> $('.checkme:checked').length

    totalNumberOfCheckboxes = -> $('.checkme').length

    $('#selectall').on 'click', ->
        if @checked
            $(':checkbox').each ->
                $(@).prop('checked', true)
        else
            $(':checkbox').each ->
                $(@).prop('checked', false)

    $(':checkbox').on 'click', ->
        if numberOfChecked() is totalNumberOfCheckboxes()
            $('#selectall').prop('checked', true)
        else
            $('#selectall').prop('checked', false)
