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

  describe "get total method" do

    it "can get register total" do
      expect(register.get_total).to eq(0)
    end

  end


  describe "update one bill type at a time" do

    it "can add value to individual bill type" do
      expect(register.add_twenties(2)).to eq(2)
    end

    it "can remove value from individual bill type" do
      expect(register.add_twenties(2)).to eq(2)
      expect(register.remove_twenties(1)).to eq(1)
    end

  end

  describe "cannot enter invalid bill values" do

    it "cannot add a letter value to a bill type" do
      expect(register.add_twenties('a')).to eq(nil)
      expect(register.twenties).to eq(0)
    end

    it "cannot add a negative integer to a bill type" do
      expect(register.add_tens(-2)).to eq(nil)
      expect(register.tens).to eq(0)
    end

    it "cannot remove a letter value from individual bill type" do
      expect(register.add_ones(2)).to eq(2)
      expect(register.remove_ones('a')).to eq(nil)
    end

    it "cannot remove more than what is there from individual bill type" do
      expect(register.add_fives(2)).to eq(2)
      expect(register.remove_fives(3)).to eq(nil)
    end

  end

  describe "add to register method" do

    it "can add to all bills types at once" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.twenties).to eq(2)
      expect(register.tens).to eq(4)
      expect(register.fives).to eq(6)
      expect(register.twos).to eq(2)
      expect(register.ones).to eq(10)
      expect(register.get_total).to eq(124)
    end

    it "can add to less than all bill types as once" do
      register.add_to_register({"twenties" => 2})
      expect(register.twenties).to eq(2)
      expect(register.get_total).to eq(40)
    end

  end

  describe "subtract from register method" do

    it "can subtract from all bills types at once" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      register.subtract_from_register({"twenties" => 1, "tens" => 4, "fives" => 3, "twos" => 0, "ones" => 9})
      expect(register.twenties).to eq(1)
      expect(register.tens).to eq(0)
      expect(register.fives).to eq(3)
      expect(register.twos).to eq(2)
      expect(register.ones).to eq(1)
      expect(register.get_total).to eq(40)
    end

    it "can subtract from less than all bill types at once" do
      register.add_to_register({"twenties" => 2})
      expect(register.get_total).to eq(40)
      register.subtract_from_register({"twenties" => 1})
      expect(register.twenties).to eq(1)
      expect(register.get_total).to eq(20)
    end

  end

  describe "get moneys as string methods" do

    it "can get bill types as strings" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.get_twenties_as_str).to eq('2')
      expect(register.get_tens_as_str).to eq('4')
      expect(register.get_fives_as_str).to eq('6')
      expect(register.get_twos_as_str).to eq('2')
      expect(register.get_ones_as_str).to eq('10')
    end

    it "can get total as string" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.get_total_as_str).to eq('124')
    end

  end

  describe "make change from register" do

    it "can make change and update register correctly, scenario 1" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.get_total).to eq(124)
      register.make_change(20)
      expect(register.get_total).to eq(104)
    end

    it "can make change and update register correctly, scenario 2" do
      register.add_to_register({"twenties" => 2, "tens" => 4, "fives" => 6, "twos" => 2, "ones" => 10})
      expect(register.get_total).to eq(124)
      register.make_change(38)
      expect(register.get_total).to eq(86)
    end

    it "can make change and update register correctly, scenario 3" do
      register.add_to_register({"tens" => 4, "twos" => 2, "ones" => 10})
      expect(register.get_total).to eq(54)
      register.make_change(38)
      expect(register.get_total).to eq(16)
    end

    it "cannot make change if insufficient funds" do
      register.add_to_register({"twenties" => 1, "tens" => 0, "fives" => 3, "twos" => 1, "ones" => 1})
      expect(register.make_change(14)).to eq (nil)
    end

  end

  describe "albert tests" do

    it "albert scenario" do
      register.add_to_register({"twenties" => 1, "fives" => 3, "twos" => 4})
      expect(register.get_total).to eq(43)
      register.make_change(11)
      expect(register.get_total).to eq(32)
    end

    it "cy scenario" do
      register.add_to_register({"twenties" => 1, "fives" => 3, "ones" => 4})
      expect(register.get_total).to eq(39)
      register.make_change(11)
      expect(register.get_total).to eq(28)
    end

    it "cy scenario 2" do
      register.add_to_register({"tens" => 1, "fives" => 3, "ones" => 4})
      expect(register.get_total).to eq(29)
      register.make_change(11)
      expect(register.get_total).to eq(18)
    end

    it "cy scenario 3" do
      register.add_to_register({"fives" => 3, "twos" => 4})
      expect(register.get_total).to eq(23)
      register.make_change(21)
      expect(register.get_total).to eq(2)
    end

    it "cy scenario 4" do
      register.add_to_register({"tens" => 1, "fives" => 3, "twos" => 4})
      expect(register.get_total).to eq(33)
      register.make_change(16)
      expect(register.get_total).to eq(17)
    end

  end


end