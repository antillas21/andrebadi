jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

  $('nav-collapse li').live 'click', ->
    console.log 'clicked menu link'
