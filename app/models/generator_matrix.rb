# Generuojancia matrica reprezentuojanti klase
# TODO nuo rm(4,5) buna ragas, nes
# gaunam x0,x1,x2,x3,x4...xm, 
# o m-tosios eilutes jau nera

class GeneratorMatrix < ActiveRecord::Base
  include Enumerable
  attr_accessible :cols, :rows

  validates :rows, presence: true
  validates :cols, presence: true
  validate :cols_must_be_2_power
  after_initialize :generate_matrix

  # Naudojama Enumerable mixino tam,
  # kad sukurti ivairius iteraciju metodus
  def each
    @matrix.each { |row| yield row }
  end

  # Grazina n-taja matricos eilute
  def [] n
    @matrix[n]
  end

  protected 

    # Sugeneruojama matrica
    def generate_matrix
      return unless self.valid?
      all_blocks = self.generate_blocks
      @matrix = []
      
      # Pridedam 1..1
      @matrix << all_blocks[0]
      
      # Pradedam nuo x0
      indexes = [0]

      # Pridedam likusias eilutes
      (self.rows-1).times do |row|
        @matrix << multiply_rows(all_blocks[1], indexes)
        indexes = self.increment_indexes(indexes)
      end
    end

    # Grazina vektorius, is kuriu sudarinejame matrica
    # Rezultate fi(1) ir fi(x0)..fi(m)
    def generate_blocks
      blocks = []
      m = self.m
      (m-1).downto(0) do |power|
        inner_blocks = []
        block_len = 2 ** power
        num_blocks = self.cols / block_len
        ones = true
        num_blocks.times do |block_no|
          inner_blocks << [bool_to_int(ones)] * block_len
          ones = !ones
        end
        blocks << inner_blocks
      end

      [ BinaryVector.new(elements: ([1] * self.cols).join('')), 
        blocks.flatten(0).map { |b| BinaryVector.new(elements: b.join('')) }]
    end

    # Sudaugina eilutes nurodytais indexais
    def multiply_rows(array, indexes)
      result = array[indexes[0]]
      (1..(indexes.count-1)).each do |index| 
        result *= array[indexes[index]]
      end
      result
    end

    # Isrenka sekancios permutacijos eiluciu indexus
    # pvz. m = 4
    # jei indexes = [1,2], tai grazins [1,3]
    # jei indexes = [2,3], tai grazins [0,1,2]
    def increment_indexes(indexes)
      num_indexes = indexes.count
      critical_index = self.m - 1

      (indexes.count-1).downto(0) do |index|
        if indexes[index] < critical_index
          indexes[index] += 1
          (index+1..num_indexes-1).each do |index|
            indexes[index] = indexes[index-1] + 1
            return new_indexes_level(num_indexes) if indexes[index] > critical_index
          end
          return indexes
        end
      end

      return new_indexes_level num_indexes
    end

    # Grazina sekancio lygio indexus
    # pvz. jei num_indexes = 1, tai grazins [0,1]
    def new_indexes_level(num_indexes)
      indexes = []
      (0..num_indexes).
        each { |i| indexes << i }
      indexes
    end

    # Suskaicuoja m pagal stulpeliu skaiciu
    def m
      m_calculation[0]
    end

    def m_calculation
      result = 0
      counter = self.cols
      while counter >= 2.0
        result += 1
        counter /= 2.0
      end
      [result, counter]
    end

    # Pavercia boolean reiksme i integeri (0 arba 1)
    def bool_to_int b
      b ? 1 : 0
    end

    # Patikrina, kad matricos stulpeliu skaicius butu
    # dvejeto laipsnis
    def cols_must_be_2_power
      if !self.cols.nil? && self.m_calculation[1] != self.m_calculation[1].to_i
        errors.add(:cols, "#{self.cols} is not 2^m")
      end
    end
end