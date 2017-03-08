class Register < ActiveRecord::Base
  class NoBills < StandardError
  end

  validates :twenties, :tens, :fives, :twos, :ones, presence: true

  def add_to_register(amount_hash)
    self.twenties += amount_hash["twenties"]
    self.tens += amount_hash["tens"]
    self.fives += amount_hash["fives"]
    self.twos += amount_hash["twos"]
    self.ones += amount_hash["ones"]
    self.save
  end

  def subtract_from_register(amount_hash)
    #add error for going below 0
    self.twenties -= amount_hash["twenties"]
    self.tens -= amount_hash["tens"]
    self.fives -= amount_hash["fives"]
    self.twos -= amount_hash["twos"]
    self.ones -= amount_hash["ones"]
    self.save
  end


  def make_change(amount)
    nums = {"twenties" => 0, "tens" => 0, "fives" => 0, "twos" => 0, "ones" => 0}

    #checks
    def check_for_tens(new_amount, nums)
      if self.tens != 0 && new_amount >= 10
        needed_10s = (new_amount/10).floor
          if needed_10s <= self.tens
            nums["tens"] = needed_10s
            remaining = (new_amount % 10)
            if remaining >= 5
              check_for_fives(remaining, nums)
            elsif remaining >= 2
              check_for_twos(remaining, nums)
            elsif remaining >= 1
              check_for_ones(remaining, nums)
            else
              self.subtract_from_register(nums)
            end
          else
            check_for_fives(new_amount, nums)
          end
      else
        check_for_fives(new_amount, nums)
      end
    end

    def check_for_fives(new_amount, nums)
      if self.fives != 0 && new_amount >= 5
          needed_5s = (new_amount/5).floor
            if needed_5s <= self.fives
              nums["fives"] = needed_5s
              remaining = (new_amount % 5)
              if remaining >= 2
                check_for_twos(remaining, nums)
              elsif remaining >= 1
                check_for_ones(remaining, nums)
              else
                self.subtract_from_register(nums)
              end
            else
              check_for_twos(new_amount, nums)
            end
      else
        check_for_twos(new_amount, nums)
      end
    end

    def check_for_twos(new_amount, nums)
      if self.twos != 0 && new_amount >= 2
          needed_2s = (new_amount/2).floor
            if needed_2s <= self.twos
              nums["twos"] = needed_2s
              remaining = (new_amount % 2)
              if remaining >= 1
                check_for_ones(remaining, nums)
              else
                self.subtract_from_register(nums)
              end
            else
              check_for_ones(new_amount, nums)
            end
      else
        check_for_ones(new_amount, nums)
      end
    end

    def check_for_ones(new_amount, nums)
      if self.ones != 0 && new_amount >= 1
            if new_amount <= self.ones
              nums["ones"] = new_amount
              self.subtract_from_register(nums)
            else
             # raise NoBillsError, "Not enough bills"
             return "error"
            end
      else
        #raise NoBillsError, "Not enough bills"
        return "error"
      end
    end

    #20s check
    if self.twenties != 0 && amount >= 20
      needed_20s = (amount/20).floor
      if needed_20s <= self.twenties
        nums["twenties"] = needed_20s
        remaining = (amount % 20)
          if remaining >= 10
            check_for_tens(remaining, nums)
          elsif remaining >= 5
            check_for_fives(remaining, nums)
          elsif remaining >= 2
            check_for_twos(remaining)
          elsif remaining >= 1
            check_for_ones(remaining)
          else
            self.subtract_from_register(nums)
          end
      else
        check_for_tens(amount, nums)
      end
    else
      check_for_tens(amount, nums)
    end
  end


  def get_total
    total = 0
    total += (self.twenties * 20)
    total += (self.tens * 10)
    total += (self.fives * 5)
    total += (self.twos * 2)
    total += self.ones
    total
  end





end