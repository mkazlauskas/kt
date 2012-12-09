# Rydo-Miulerio koda reprezentuojanti klase

class ReedMuller < ActiveRecord::Base
  include MathHelper

  attr_accessible :m, :r

  # Validuoja kodo parametrus
  validates :r, presence: true, numericality: { greater_than_or_equal_to: 0 }, reduce: true
  validates :m, presence: true, numericality: true, reduce: true
  validate :r_is_less_than_or_equal_to_m

  # Sukuria nauja vektoriu, kuri veliau uzkoduosime
  def new_message
    return nil if !self.valid?
    BinaryVector.new(size: code_length)
  end

  # Sukuria generuojancia matrica
  def generator_matrix
    GeneratorMatrix.new(rows: code_length, cols: 2 ** m)
  end

  private

    def r_is_less_than_or_equal_to_m
      return if self.r.nil? || self.m.nil?
      errors.add(:r, "must be less than or equal to M (#{r}>#{m})") \
        if self.r > self.m
    end

    # Uzkoduojamo vektoriaus ilgis
    def code_length
      length = 0
      (0..r).each do |k|
        length += num_combinations(m, k)
      end
      length
    end
end