Handlebars.registerHelper 'toCurrency', (amount) ->
  accounting.formatMoney amount,
    symbol: '$'
    precision: 2
    thousand: ','
    format:
      pos: "%s %v"
      neg: "- %s %v"
      zero: "%s %v"

Handlebars.registerHelper 'formattedDate', (date) ->
  moment(date).format('MMM D, YYYY • H:mm')

Handlebars.registerHelper 'formattedDateOnly', (date) ->
  moment(date).format('MMM D, YYYY')

Handlebars.registerHelper 'toCents', (amount) ->
  amount * 100

Handlebars.registerHelper 'downcasePluralize', (type) ->
   type.toLowerCase() + 's'
