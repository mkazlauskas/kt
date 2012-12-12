# Rydo-Miulerio koda reprezentuojanti klase

class ReedMuller < ActiveRecord::Base
  include MathHelper
  include ReedMullerHelper

  attr_accessible :m, :r
  has_one :binary_vector
  has_one :string_message
  has_one :channel

  # Validuoja kodo parametrus
  validates :r, presence: true, numericality: { greater_than_or_equal_to: 1 }, reduce: true
  validates :m, presence: true, numericality: true, reduce: true
  validate :r_is_less_than_or_equal_to_m

  # Sukuria generuojancia matrica
  def generator_matrix
    GeneratorMatrix.new(rows: code_length, cols: 2 ** m)
  end

  # Uzkoduoja duota vektoriu
  def encode_vector(vector)
    vector * self.generator_matrix
  end

  # Dekoduoja duota vektoriu
  def decode_vector(vector)
    majority_logic_decoder(self.generator_matrix, vector)
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

    # r parametro validacija
    def r_is_less_than_or_equal_to_m
      return if self.r.nil? || self.m.nil?
      errors.add(:r, "must be less than to M (#{r}>#{m})") \
        if self.r >= self.m
    end
end