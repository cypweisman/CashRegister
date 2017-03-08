require "rails_helper"

describe Register do

  let(:register) { Register.create!(twenties: 0, tens: 0, fives: 0, twos: 0, ones: 0) }

  describe "attributes" do

    it "has twenties" do
      expect(register.twenties).to eq(0)
    end

    it "has tens" do
      expect(register.tens).to eq(0)
    end

    it "has fives" do
      expect(register.fives).to eq(0)
    end

    it "has twos" do
      expect(register.twos).to eq(0)
    end

    it "has ones" do
      expect(register.ones).to eq(0)
    end
  end

  describe "get total" do

    it "can get register total" do
      expect(register.get_total).to eq(0)
    end

  end

  describe "add to register" do

    it "can add to register" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.twenties).to eq(2)
      expect(register.tens).to eq(4)
      expect(register.fives).to eq(6)
      expect(register.twos).to eq(2)
      expect(register.ones).to eq(10)
      expect(register.get_total).to eq(124)
    end

  end

  describe "subtract from register" do

    it "can subtract from register" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      register.subtract_from_register({"twenties" => 1, "tens" => 4, "fives" => 3, "twos" => 0, "ones" => 9})
      expect(register.twenties).to eq(1)
      expect(register.tens).to eq(0)
      expect(register.fives).to eq(3)
      expect(register.twos).to eq(2)
      expect(register.ones).to eq(1)
      expect(register.get_total).to eq(40)
    end

  end




end