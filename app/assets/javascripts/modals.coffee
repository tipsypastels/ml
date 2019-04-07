$(document).on 'click', '[data-modal]', ->
  $el = $(this)
  type = $el.attr('data-modal')

  switch type
    when 'toggle'
      $('#modal').toggleClass 'is-active'
    when 'open'
      $('#modal').addClass 'is-active'
    when 'close'
      $('#modal').removeClass 'is-active'