class StringMessage < ActiveRecord::Base
  attr_accessible :message
  belongs_to :reed_muller
  validates :message, presence: true, length: { minimum: 1 }

  def bits_array(count)
    bits = ''
    self.message.each_char { |c| bits << ascii_to_8bits(c.ord) }
    while bits.length % count != 0
      bits << '0'
    end
    result = []
    (0...bits.length).step(count) do |start_index|
      result << bits[start_index...start_index+count]
    end
    result
  end

  def load_bits(bits)
    without_redundant = bits[0...(bits.length - (bits.length % 8))]
    self.message = ''
    (0...without_redundant.length).step(8) do |start_index|
      chunk_bits = without_redundant[start_index...start_index+8]
      # throw chunk_bits if start_index + 8 == without_redundant.length
      ascii = chunk_bits.to_i(2)
      self.message << ascii
    end
  end

  def ascii_to_8bits(ascii)
    bin = ascii.to_s(2)
    (8 - bin.length).times { bin = '0' + bin }
    bin
  end

  def to_s
    self.message
  end
end