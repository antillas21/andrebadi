class TransactionMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sales.invoice.subject
  #
  def invoice( sale, customer, store_owner )
    @sale = sale
    @customer = customer

    mail( to: "#{@customer.name} <#{@customer.email}>", from: store_owner.email,
          subject: 'Your purchase with Lizbeth Ojeda' )
  end

  def receipt( payment, customer, store_owner )
    @payment = payment
    @customer = customer

    mail( to: "#{@customer.name} <#{@customer.email}>", from: store_owner.email,
          subject: 'Your payment receipt.' )
  end
end
