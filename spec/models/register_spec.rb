require "rails_helper"

describe Register do

  let(:register) { Register.create! }

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
      expect(register.get_total).to eq('0')
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
      expect(register.get_total).to eq('124')
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
      expect(register.get_total).to eq('40')
    end

  end

  describe "make change from register" do

    it "can make change, 20s" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.get_total).to eq('124')
      register.make_change(20)
      #expect (print(make_change(20)).to output('1 20s').to_stdout )

      expect(register.get_total).to eq('104')
    end

    it "can make change, 20s, 10s, 5s, 2s, 1s" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      register.make_change(38)
      expect(register.get_total).to eq('86')
    end


    it "can make error" do
      register.add_to_register({"twenties" => 1, "tens" => 0, "fives" => 3, "twos" => 1, "ones" => 1})
      expect(register.make_change(14)).to eq "Sorry, can't make change"
    end

  end


end