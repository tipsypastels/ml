$(document).on 'click', '.burger, .dropdown-trigger', ->
    $el = $(this)
    target = $el.attr('data-target')
    
    $el.toggleClass('is-active')
    $("##{target}").toggleClass('is-active')