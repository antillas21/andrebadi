Handlebars.registerHelper('toCurrency', function(amount){
  return accounting.formatMoney(amount);
});

Handlebars.registerHelper('formattedDate', function(date){
  return moment(date).format('MMM D YYYY, h:mm:ss a');
});
