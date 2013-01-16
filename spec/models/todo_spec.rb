require 'spec_helper'

describe Todo do
  before :each do
    @todo= FactoryGirl.create :todo
  end

  describe "Class functions" do

  end

  describe "Relations" do
  
  end

  describe "Validations" do

    describe "Success" do
      it "should create given valid attributes" do
        @todo.should be_valid
      end
    end
    
    describe "Failure" do
      it "should not be valid without position" do
        @todo.should_not accept_values_for :position, nil
      end

      it "should not be valid without text" do
        @todo.should_not accept_values_for :text, nil
      end
    end

  end
end
