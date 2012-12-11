class Channel < ActiveRecord::Base
  attr_accessible :reliability
  belongs_to :reed_muller

  validates :reliability, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

  def send_vector(vector)
    ruined_elements = ''
    vector.each do |element|
      ruined_elements << (self.ruin? ? opposite(element) : element)
    end
    BinaryVector.new(elements: ruined_elements)
  end

  def self.diff(first, second)
    result = []
    (0...(first.length)).each do |index|
      (result << index) if first[index] != second[index]
    end
    result
  end

  protected

    def ruin?
      r = Random.new
      r.rand(1..100) > reliability.to_i
    end

    def opposite(bit)
      bit == '1' ? '0' : '1'
    end
end