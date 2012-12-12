# Modulis, skirtas Majority Logic dekodavimo algoritmui

module ReedMullerHelper

  # Metodas, kuri reikia kviesti norint dekoduoti
  def majority_logic_decoder(generator_matrix, encoded_original_vector)
    encoded_vector = encoded_original_vector
    decoded = ''

    # Pagal pirmo lygio indeksus nustatome, is ko sudaryti kombinacijas
    first_level = generator_matrix.building_indexes.select { |i| i.count == 1 }.map { |i| i[0] }

    # Sekame, ar dar nepriejome naujo lygio
    # ir sumuojame einamojo lygio rezultatu suma
    last_level = generator_matrix.building_indexes.last.count
    level_sum = BinaryVector.new(elements: '0' * generator_matrix.cols)

    all_indexes = generator_matrix.building_indexes
    all_indexes.reverse.each do |indexes|
      vectors = []

      # Jei naujas lygis, pridedame praeito lygio
      # suma prie uzkoduoto vektoriaus
      if indexes.count != last_level
        encoded_vector += level_sum
        last_level = indexes.count
        level_sum = BinaryVector.new(elements: '0' * generator_matrix.cols)
      end

      # Sudarome matricos pradiniu vektoriu ir
      # ju priesingu vektoriu sarasa
      (first_level - indexes).each do |index|
        vectors << [index, generator_matrix.building_vectors[index]]
        vectors << [index, inverse(generator_matrix.building_vectors[index])]
      end

      # Is to saraso, sudarome tinkamas kombinacijas
      combinations = vectors.combination(generator_matrix.m - indexes.count).
        select { |combination| take_combination?(combination) }.
        map do |combination| 
          result = []
          combination.each do |vector|
            result << vector[1]
          end
          result
        end

      # Su kiekviena kombinacija tikriname,
      # ko daugiau: 0 ar 1
      votes = [0, 0]
      combinations.each do |combination|
        mult = combination.inject { |r, v| r *= v }
        vote = (mult * encoded_vector).elements.count('1') % 2
        votes[vote] += 1
      end

      final_vote = ((votes[0] > votes[1]) ? '0' : '1')

      # Jeigu galutinis rezultatas 1, pridedame ji prie
      # uzkoduoto vektoriaus sekanciu lygiu skaiciavimui
      if final_vote == '1'
        level_vector = indexes.
          map { |i| generator_matrix.building_vectors[i] }.
          inject { |s, i| s *= i }
        level_sum += level_vector
      end

      decoded = final_vote + decoded
    end

    # Suskaiciuojame ir pridedam nulini lygi
    encoded_vector += level_sum
    first = (encoded_vector.count('1') > (generator_matrix.cols / 2)) ? '1' : '0' 
    decoded = first + decoded

    BinaryVector.new(elements: decoded)
  end

  # Grazina sekancio lygio
  # matricos konstravimo vektoriu indeksus
  # ir pasalina juos is saraso
  def get_last_level_indexes(building_indexes)
    last_level_length = building_indexes.first.count
    last_level_indexes = building_indexes.select { |i| i.count == last_level_length }
    last_level_indexes.each { |i| building_indexes.delete(i) }
    last_level_indexes
  end

  # Kiekviena 0 pakeicia i 1 ir atvirksciai
  def inverse(vector)
    result = ''
    vector.each do |element|
      result += (element == '1') ? '0' : '1'
    end
    BinaryVector.new(elements: result)
  end

  # Ar itraukti sia kombinacija i skaiciavima?
  # Tai priklauso nuo to, joje nera pasikartojimu
  def take_combination?(combination)
    taken = []
    (0...combination.count).each do |vector_index|
      return false if taken.include?(combination[vector_index][0])
      taken << combination[vector_index][0]
    end
    true
  end
end