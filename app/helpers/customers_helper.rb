module CustomersHelper
  def transaction_type_link(transaction)
    if transaction.type == 'Payment'
      link_to "<i class='icon-eye-open'></i> View".html_safe, payment_path(transaction)
    else
      link_to "<i class='icon-eye-open'></i> View".html_safe, sale_path(transaction)
    end
  end
end
