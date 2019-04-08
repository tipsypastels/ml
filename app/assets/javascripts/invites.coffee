$(document).on 'click', 'input[data-copy]', ->
  $input = $(this)
  copyText = $input.attr('data-copy') || 'Copied to clipboard!'
  this.select()  
  document.execCommand('copy')
  $input.val(copyText);