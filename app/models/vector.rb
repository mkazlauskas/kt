# Vektoriu reprezentuojanti klase

class Vector < ActiveRecord::Base
  include Enumerable

  attr_accessible :body, :elements, :size

  # Validuoja vektoriaus elementus pagal
  # duota kuna ir vektoriaus dydi
  validates :body, presence: true
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
    return elements[n]
  end

  private

    # Validuoja, ar vektoriaus elementai susideda
    # tik is duoto kuno elementu
    def elements_must_consist_of_body
      return if self.body.blank? || self.elements.blank?
      self.elements.each_char do |e|
        if !self.body.include? e
          errors.add(:elements, "Vector with body #{self.body} and elements #{self.elements} contains illegal element #{e}")
          break
        end
      end
    end

    # Validuoja, ar vektorius turi 
    # reikiama skaiciu elementu
    def elements_must_have_specified_length
      return if size.nil?
      errors.add(
        :size, 
        "Vector #{self.elements} has #{self.elements.length} characters, but it's size was set to #{self.size}") \
          if self.elements.length != self.size
    end
end