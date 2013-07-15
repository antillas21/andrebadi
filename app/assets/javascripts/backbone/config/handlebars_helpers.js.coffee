Handlebars.registerHelper 'toCurrency', (amount) ->
  accounting.formatMoney amount

Handlebars.registerHelper 'formattedDate', (date) ->
  moment(date).format('MMM D, YYYY • h:mm a')

Handlebars.registerHelper 'formattedDateOnly', (date) ->
  moment(date).format('MMM D, YYYY')
