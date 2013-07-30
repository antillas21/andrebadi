$ ->
  $('.nav-collapse li').on 'click', (link) ->
    parentCont = $(link.currentTarget).parent().parent()
    parentCont.toggleClass('in').css('height', '0')

    parentCont.siblings('.btn-navbar').toggleClass('collapsed')

  SaleTrackr.start
    appContainer: '#main-region'


