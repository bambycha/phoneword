# frozen_string_literal: true

require 'pry'
require 'phoneword'

RSpec.describe Phoneword, '#search_words' do
  subject { described_class.new }

  context 'with first example from the task' do
    let(:number) { '6686787825' }

    it 'includes words from the answer example' do
      expect(subject.search_words(number))
        .to include %w[motor usual],
                    %w[noun struck],
                    %w[nouns truck],
                    %w[nouns usual],
                    %w[onto struck],
                    ['motortruck']
    end

    xit 'includes all possible words combinations' do
      # FIXME: Rework Naïve algorithm to find all possibles matches
      expect(subject.search_words(number))
        .to include %w[motor usual],
                    %w[noun struck],
                    %w[nouns truck],
                    %w[nouns usual],
                    %w[onto struck],
                    ['motortruck'],
                    %w[noun pup taj],
                    %w[mot opts taj],
                    %w[noun pup taj],
                    %w[onto pup taj],
                    %w[mot opt puck]
    end
  end

  context 'with second example from the task' do
    let(:number) { '2282668687' }

    it 'includes words from the answer example' do
      expect(subject.search_words(number))
        .to include %w[act amounts],
                    %w[act contour],
                    %w[acta mounts],
                    %w[bat amounts],
                    %w[bat contour],
                    %w[cat contour],
                    ['catamounts']
    end
  end
end

RSpec.describe Phoneword, '#search_words', type: :performance, performance: true do
  let(:number) { '6686787825' }

  it 'performs under 1000ms' do
    instance = described_class.new

    expect { instance.search_words(number) }.to perform_under(100).ms
    # NOTE: we need more examples to verify perf yet I'm ruby dev to type all of them here 😅
    # but only for this purpose surely
  end
end
