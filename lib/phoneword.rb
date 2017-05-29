# frozen_string_literal: true

require 'dictionary'

class Phoneword
  def initialize
    @dictionary = Dictionary.new.words_with_numbers
    @result = []
  end

  attr_reader :dictionary, :result

  def search_words(search_number)
    # OPTIMIZE: Rework Naïve algorithm to decrease Big-O(dictionary#size²)
    words_in_number_list = words_in_number_seq(search_number)

    words_in_number_list.each do |word|
      find_phrase(word: word,
                  words_list: words_in_number_list,
                  number: search_number,
                  result_set: [])
    end

    convert_to_output_format(result)
  end

  private

  def find_phrase(word:, words_list:, number:, result_set:)
    word_size = word_text(word).size
    if number[0, word_size] == word_number(word)
      result_set << word
      remain_number = number[word_size..-1]

      if remain_number == ''
        result << result_set unless result.include?(result_set)
        result_set = result_set.slice(0..-2)
        remain_number = number
      end
    else
      remain_number = number
    end

    search_next_word(word: word,
                     words_list: words_list,
                     remain_number: remain_number,
                     result_set: result_set)
  end

  def search_next_word(word:, words_list:, remain_number:, result_set:)
    remain_seq = words_list.reject { |key| key == word_text(word) }

    return if remain_seq.empty?

    find_phrase(word: remain_seq.first,
                words_list: remain_seq,
                number: remain_number,
                result_set: result_set)
  end

  def word_number(w)
    w[1]
  end

  def word_text(w)
    w[0]
  end

  def convert_to_output_format(result)
    result.each { |a| a.map! { |i| i.first.downcase } }
  end

  def words_in_number_seq(search_number)
    dictionary
      .select { |_, number| search_number.include?(number) && number.size >= 3 }
      .sort_by { |_, v| -v.size }.to_h
  end
end
