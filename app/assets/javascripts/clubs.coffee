$(document).on 'turbolinks:load', ->
  $('[data-show-on-edit]').keyup ->
    $form = $(this)
    targetName = $form.attr('data-show-on-edit')

    $target = $("##{targetName}")

    unlessEqual = $form.attr('data-unless-equal')
    if ($form.val() is unlessEqual)
      $target.slideUp(200);
    else
      $target.slideDown(200)