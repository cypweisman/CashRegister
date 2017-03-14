class Register < ActiveRecord::Base

  #ADD TO A GIVEN BILL METHODS

  def add_twenties(bills)
    if bills.is_a? Integer
        if bills > 0
            self.twenties += bills
        end
    else
        puts "Please enter an integer"
    end
  end

  def add_tens(bills)
    if bills.is_a? Integer
        if bills > 0
            self.tens += bills
        end
    else
       puts "Please enter an integer"
    end
  end

  def add_fives(bills)
    if bills.is_a? Integer
        if bills > 0
            self.fives += bills
        end
    else
        puts "Please enter an integer"
    end
  end

  def add_twos(bills)
    if bills.is_a? Integer
        if bills > 0
            self.twos += bills
        end
    else
        puts "Please enter an integer"
    end
  end

  def add_ones(bills)
    if bills.is_a? Integer
        if bills > 0
            self.ones += bills
        end
    else
        puts "Please enter an integer"
    end
  end

  #SUBTRACT FROM A GIVEN BILL METHODS

  def remove_twenties(bills)
    if bills.is_a? Integer
        if bills <= self.twenties
            self.twenties -= bills
        else
            puts "Insufficient funds"
        end
    else
        puts "Please enter an integer"
    end
  end

  def remove_tens(bills)
    if bills.is_a? Integer
        if bills <= self.tens
            self.tens -= bills
        else
            puts "Insufficient funds"
        end
    else
        puts "Please enter an integer"
    end
  end

  def remove_fives(bills)
    if bills.is_a? Integer
        if bills <= self.fives
            self.fives -= bills
        else
            puts "Insufficient funds"
        end
    else
        puts "Please enter an integer"
    end
  end

  def remove_twos(bills)
    if bills.is_a? Integer
        if bills <= self.twos
            self.twos -= bills
        else
            puts "Insufficient funds"
        end
    else
        puts "Please enter an integer"
    end
  end

  def remove_ones(bills)
    if bills.is_a? Integer
        if bills <= self.ones
            self.ones -= bills
        else
            puts "Insufficient funds"
        end
    else
        puts "Please enter an integer"
    end
  end

  #GET AS STRING METHODS

  def get_twenties_as_str
    self.twenties.to_s
  end

  def get_tens_as_str
    self.tens.to_s
  end

  def get_fives_as_str
    self.fives.to_s
  end

  def get_twos_as_str
    self.twos.to_s
  end

  def get_ones_as_str
    self.ones.to_s
  end

  def get_total_as_str
    total = self.get_total
    total.to_s
  end


  def add_to_register(amount_hash)
    if amount_hash["twenties"]
        add_twenties(amount_hash["twenties"])
    end

    if amount_hash["tens"]
        add_tens(amount_hash["tens"])
    end

    if amount_hash["fives"]
        add_fives(amount_hash["fives"])
    end

    if amount_hash["twos"]
        add_twos(amount_hash["twos"])
    end

    if amount_hash["ones"]
        add_ones(amount_hash["ones"])
    end
  end

  def subtract_from_register(amount_hash)
    if amount_hash["twenties"]
        remove_twenties(amount_hash["twenties"])
    end

    if amount_hash["tens"]
        remove_tens(amount_hash["tens"])
    end

    if amount_hash["fives"]
        remove_fives(amount_hash["fives"])
    end

    if amount_hash["twos"]
        remove_twos(amount_hash["twos"])
    end

    if amount_hash["ones"]
        remove_ones(amount_hash["ones"])
    end
  end


  def make_change(amount)
    amount = amount
    change_hash = {20 => 0, 10 => 0, 5 => 0, 2 => 0, 1 => 0}
    register_content = {20 => self.twenties, 10 => self.tens, 5 => self.fives, 2 => self.twos, 1 => self.ones}
    previous_denom = 0
    previous_amount = 0
    previous_bills_needed = 0
    enough_previous_bills = false

    register_content.each do |denom, num_bills|

      if num_bills !=0 && amount >= denom
        enough_previous_bills = true
        bills_needed = (amount/denom).floor
        previous_amount = amount
        previous_denom = denom
        previous_bills_needed = bills_needed
        if bills_needed <= num_bills
          change_hash[denom] = bills_needed
          amount = (amount % denom)
          if amount == 0
            break
          end
        elsif bills_needed > num_bills
          change_hash[denom] = num_bills
          amount = (amount - (denom * num_bills))
        end
      elsif enough_previous_bills == true
          new_amount = (previous_amount - (previous_denom * (previous_bills_needed -1)))
          if new_amount >= denom
             bills_needed = (new_amount/denom).floor
            if bills_needed <= num_bills
               change_hash[denom] = bills_needed
               change_hash[previous_denom] = (previous_bills_needed - 1)
               amount = (new_amount % denom)
            end
          end
      end
    end

    def print_change(change_hash)
      print_out = ''
      change_hash.each do |denom, num_bills|
        if num_bills != 0
          print_out += "#{num_bills} #{denom}s, "
        end
      end
      print_out += "is your change"
      puts print_out
    end

    def remove_change(change_hash)
      new_keys = {20 => "twenties", 10 => "tens", 5 => "fives", 2 => "twos", 1 => "ones"}
      dupl = change_hash.map {|k, v| [new_keys[k], v] }.to_h
      self.subtract_from_register(dupl)
    end

    if amount != 0
      puts "Sorry, can't make change"
    else
      print_change(change_hash)
      remove_change(change_hash)
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