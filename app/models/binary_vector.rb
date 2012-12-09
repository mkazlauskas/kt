# Vektoriu reprezentuojanti klase

class BinaryVector < ActiveRecord::Base
  include Enumerable

  attr_accessible :elements, :size

  # Validuoja vektoriaus elementus pagal
  # kuna 01 ir vektoriaus dydi
  validates :elements, presence: true
  validate :elements_must_consist_of_body
  validate :elements_must_have_specified_length

  # Naudojama Enumerable mixino tam,
  # kad sukurti ivairius iteraciju metodus
  def each 
    self.elements.each_char { |c| yield c }
  end

  # Grazina n-taji vektoriaus elementa,
  # indeksuojant nuo 0
  def [] n
    elements[n]
  end

  # Ar tai toks pats vektorius?
  def == other
    self.elements == other.elements
  end

  def * other
    new_elements = ''
    (0..self.count-1).each { |i| new_elements << 
      (self[i].to_i * other[i].to_i).to_s }
    BinaryVector.new(elements: new_elements)
  end

  private

    # Validuoja, ar vektoriaus elementai susideda
    # tik is duoto kuno elementu
    def elements_must_consist_of_body
      return if self.elements.blank?
      self.elements.each_char do |e|
        if !'01'.include? e
          errors.add(:elements, "#{self.elements} contains illegal element #{e}")
          break
        end
      end
    end

    # Validuoja, ar vektorius turi 
    # reikiama skaiciu elementu
    def elements_must_have_specified_length
      return if size.nil? || self.elements.blank?
      errors.add(
        :size, 
        "#{self.elements} has #{self.elements.length} characters, but it's size was set to #{self.size}") \
          if self.elements.length != self.size
    end
end