# frozen_string_literal: true

require 'csv'

class Dictionary
  DICTIONARY_FILE = 'config/dictionary.csv'

  def words_with_numbers
    @_words_with_numbers ||=
      convert_dictionary_words_to_numbers
  end

  private

  def convert_dictionary_words_to_numbers
    {}.tap do |dictionary|
      dictionary_words.each { |word| dictionary[word] = convert_word_to_number(word) }
    end
  end

  def dictionary_words
    CSV.read(DICTIONARY_FILE)[0]
  end

  def convert_word_to_number(word)
    ''.dup.tap do |word_number|
      word.each_char do |char|
        case char.downcase
        when 'a', 'b', 'c'
          word_number << '2'
        when 'd', 'e', 'f'
          word_number << '3'
        when 'g', 'h', 'i'
          word_number << '4'
        when 'j', 'k', 'l'
          word_number << '5'
        when 'm', 'n', 'o'
          word_number << '6'
        when 'p', 'q', 'r', 's'
          word_number << '7'
        when 't', 'u', 'v'
          word_number << '8'
        when 'w', 'x', 'y', 'z'
          word_number << '9'
        else
          raise ArgumentError, "Translation for '#{char}' is missing"
        end
      end
    end
  end
end
