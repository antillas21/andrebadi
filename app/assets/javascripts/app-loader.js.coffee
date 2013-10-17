$ ->
  $('.nav-collapse li').on 'click', (link) ->
    parentCont = $(link.currentTarget).parent().parent()
    parentCont.toggleClass('in').css('height', '0')

    parentCont.siblings('.btn-navbar').toggleClass('collapsed')

  $('.btn-cancel').on 'click', (e) ->
    e.preventDefault()
    $(@).parents('form.form').hide('fast')

  $('.btn-add').on 'click', (e) ->
    e.preventDefault()
    $('form.form.form-hidden').show('fast')

  SaleTrackr.start
    appContainer: '#main-region'


