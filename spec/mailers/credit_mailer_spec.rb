require "spec_helper"

describe CreditMailer do
  describe "new_credit" do
    let(:mail) { CreditMailer.new_credit }

    it "renders the headers" do
      mail.subject.should eq("New credit")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
