require "spec_helper"

describe SalesMailer do
  describe "invoice" do
    let(:user) { create(:user) }
    let(:customer) { create(:customer, user: user) }
    let(:sale) { create(:sale, customer: customer) }
    let(:mail) { SalesMailer.invoice(sale, customer) }

    it "renders the headers" do
      mail.subject.should eq("Invoice")
      mail.to.should eq customer.email
      mail.from.should eq user.email
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
