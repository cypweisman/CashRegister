

class Register < ActiveRecord::Base

  #attr_accessor :twenties, :tens, :fives, :twos, :ones

  #no longer need validates
  #validates :twenties, :tens, :fives, :twos, :ones, presence: true

  def get_twenties_as_str
      #self.twenties.to_s
  end

  def add_twenties()
    #if not integet
    #pass in as interfer
  end

  def remove_twenties()
       #pass in as interfer
  end

  def add_to_register(amount_hash)
    #and if statement for eahc attribute

    #or call each individual setter
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

    amount = amount

    nums = {20 => 0, 10 => 0, 5 => 0, 2 => 0, 1 => 0}

    register_content = {20 => self.twenties, 10 => self.tens, 5 => self.fives, 2 => self.twos, 1 => self.ones}

    register_content.each do |denom, num_bills|
      # if denom == 1
      #     if num_bills !=0 && amount >= denom
      #       bills_needed = (amount/denom).floor
      #         if bills_needed <= num_bills
      #           nums[denom] = bills_needed
      #         else
      #           return "error"
      #         end
      #     else
      #       return "error"
      #     end
      if num_bills !=0 && amount >= denom
        bills_needed = (amount/denom).floor
        if bills_needed <= num_bills
          nums[denom] = bills_needed
          amount = (amount % denom)
          if amount == 0
            break
          end
        end
      end
    end

    def print_change(nums)
        nums.each do |denom, num_bills|
            if num_bills != 0
                puts "#{num_bills} #{denom}s"
            end
        end
        #puts "There is your change"
    end

    def remove_change(nums)
        new_keys = {20 => "twenties", 10 => "tens", 5 => "fives", 2 => "twos", 1 => "ones"}
        dupl = nums.map {|k, v| [new_keys[k], v] }.to_h
        self.subtract_from_register(dupl)
    end

    if amount != 0
      return "Sorry, can't make change"
    else
      print_change(nums)
      remove_change(nums)
    end

  end

  def get_total
    total = 0
    total += (self.twenties * 20)
    total += (self.tens * 10)
    total += (self.fives * 5)
    total += (self.twos * 2)
    total += self.ones
    total.to_s
  end


end