class Register < ActiveRecord::Base

  validates :twenties, :tens, :fives, :twos, :ones, presence: true

  def add_to_register(amount_hash)
    self.twenties += amount_hash["twenties"]
    self.tens += amount_hash["tens"]
    self.fives += amount_hash["fives"]
    self.twos += amount_hash["twos"]
    self.ones += amount_hash["ones"]
    self.save
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

  def subtract_from_register(amount_hash)
    #add error for going below 0
    self.twenties -= amount_hash["twenties"]
    self.tens -= amount_hash["tens"]
    self.fives -= amount_hash["fives"]
    self.twos -= amount_hash["twos"]
    self.ones -= amount_hash["ones"]
    self.save
  end





end