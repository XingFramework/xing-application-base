require 'spec_helper'

describe ActiveModelErrorConverter do
  class ActiveModelTest
    include ActiveModel::Validations

    attr_accessor :number, :cheese, :stale
    validates_numericality_of :number, :greater_than => 7
    validates_presence_of :cheese
    validates_inclusion_of :stale, :in => ["stale", "not_stale"]
  end

  let :invalid_object do
    obj = ActiveModelTest.new
    obj.stale = "sorta stale but not really"
    obj.number = 3
    obj.cheese = nil
    obj
  end

  let :expected_results do
    {
      :number => {
        type: 'greater_than_7',
        message: "must be greater than 7"
      },
      :cheese => {
        type: 'required',
        message: "can't be blank"
      },
      :stale => {
        type: 'inclusion',
        message: "is not included in the list"
      }
    }
  end

  subject :errors do
    ActiveModelErrorConverter.new(invalid_object).convert
  end

  it "should make the proper conversion" do
    expect(errors).to eql(expected_results)
  end
end
