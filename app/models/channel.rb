# Kanala reprezentuojanti klase

class Channel < ActiveRecord::Base
  attr_accessible :reliability
  belongs_to :reed_muller

  validates :reliability, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  # Iskraipo duota vektoriu (t.y. pridaro jame klaidu)
  def send_vector(vector)
    ruined_elements = ''
    vector.each do |element|
      ruined_elements << (self.ruin? ? opposite(element) : element)
    end
    BinaryVector.new(elements: ruined_elements)
  end

  # Palygina du vektorius, grazina sarasa
  # nesutampanciu poziciju
  def self.diff(first, second)
    result = []
    (0...(first.length)).each do |index|
      (result << index) if first[index] != second[index]
    end
    result
  end

  protected

    # Ar sugadinti bituka?
    def ruin?
      r = Random.new
      r.rand(1..100) > reliability.to_i
    end

    # Priesingas bitukas
    def opposite(bit)
      bit == '1' ? '0' : '1'
    end
end