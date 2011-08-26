require 'spec_helper'

describe Participant do

  before :each do
    @valid_participant = Participant.new(:name => "Bob Jones", :home_phone => "123-555-1234")
  end

  it "is valid with the test data set" do
    @valid_participant.should be_valid
  end

  describe "email validiation" do
    it "rejects a plain ol string" do
      @valid_participant.email = "veryinvalidemail"
      @valid_participant.should_not be_valid
      @valid_participant.should have(1).error_on(:email)
    end

    it "accepts a blank email addr" do
      @valid_participant.email = ""
      @valid_participant.should be_valid
      @valid_participant.should have(:no).errors_on(:email)
    end
  end

  describe "name validator" do
    it "requires a name" do
      @valid_participant.name = ""
      @valid_participant.should_not be_valid
      @valid_participant.should have(1).error_on(:name)
    end
  end

  describe "phone numbers" do
    before(:each) do
      @empty_phones = @valid_participant
      @empty_phones.home_phone = ""
      @empty_phones.mobile_phone = ""
      @empty_phones.work_phone = ""
      @empty_phones.should_not be_valid
    end

    it "requires at least one phone number" do
      @empty_phones.home_phone = "123-321-1234"
      @empty_phones.should be_valid
    end

    it "requires at least one phone number - work_phone" do
      @empty_phones.work_phone = "123-321-1234"
      @empty_phones.should be_valid
    end

    it "requires at least one phone number - mobile_phone" do
      @empty_phones.mobile_phone = "123-321-1234"
      @empty_phones.should be_valid
    end
    it "attaches the error to an in memory attribute" do
      @empty_phones = Participant.new(:name => "Sue Jones")
      @empty_phones.should_not be_valid
      @empty_phones.should have(1).error_on(:phone_numbers)
    end
  end

end
