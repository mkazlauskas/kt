# Rydo-Miulerio koda reprezentuojanti klase

class ReedMuller < ActiveRecord::Base
  attr_accessible :m, :r

  # Validuoja kodo parametrus
  validates :r, presence: true, numericality: { greater_than_or_equal_to: 0 }, reduce: true
  validates :m, presence: true, numericality: true, reduce: true
  validate :r_is_less_than_or_equal_to_m

  private

    def r_is_less_than_or_equal_to_m
      return if self.r.nil? || self.m.nil?
      errors.add(:r, "must be less than or equal to M (#{r}>#{m})") \
        if self.r > self.m
    end
end