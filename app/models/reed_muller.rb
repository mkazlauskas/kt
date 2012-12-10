# Rydo-Miulerio koda reprezentuojanti klase

class ReedMuller < ActiveRecord::Base
  include MathHelper

  attr_accessible :m, :r
  has_one :binary_vector

  # Validuoja kodo parametrus
  validates :r, presence: true, numericality: { greater_than_or_equal_to: 0 }, reduce: true
  validates :m, presence: true, numericality: true, reduce: true
  validate :r_is_less_than_or_equal_to_m

  # Sukuria generuojancia matrica
  def generator_matrix
    GeneratorMatrix.new(rows: code_length, cols: 2 ** m)
  end

  def encoded_vector
    self.binary_vector * self.generator_matrix
  end

  # Uzkoduojamo vektoriaus ilgis
  def code_length
    length = 0
    (0..r).each do |k|
      length += num_combinations(m, k)
    end
    length
  end

  private

    def r_is_less_than_or_equal_to_m
      return if self.r.nil? || self.m.nil?
      errors.add(:r, "must be less than or equal to M (#{r}>#{m})") \
        if self.r > self.m
    end
end