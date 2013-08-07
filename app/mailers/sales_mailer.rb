class SalesMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sales.invoice.subject
  #
  def invoice( sale, customer )
    @sale = sale
    @customer = customer

    mail( to: "#{@customer.name} <#{@customer.email}>", from: "user@example.com",
          subject: 'Your purchase with Lizbeth Ojeda' )
  end
end
