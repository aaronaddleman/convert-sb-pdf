require 'pdf-reader'

class Parser
  attr_accessor :input_pdf, :topics

  REGEXP = {
    "a" => {
      :level_a => Regexp.new('(?:^|\n|\s)([1-9]\s[AC-Z][a-zA-Z,\s]*?)\n{1}'),
      :level_b => Regexp.new('(?:^|\n|\s)([1-9]\.[1-9]\s[a-zA-Z,\s]*?)\n{1}')
    },
    "b" => {
      :level_a => "",
      :level_b => ""
    }
  }

  def initialize(input_pdf)
    @input_pdf = input_pdf
  end

  def reader
    PDF::Reader.new(@input_pdf)
  end

  def topics(set)
    level_a = []
    level_b = []

    self.reader.pages.each do |page|
      # puts page.text.to_s.dump
      case page.text.to_s
      when REGEXP[set][:level_a]
        # puts $1
        level_a << $1
      when REGEXP[set][:level_b]
        # puts $1
        level_b << $1
      end  
    end

    topics = {
      :level_a => level_a,
      :level_b => level_b
    }

    self.topics = topics
  end

  def find_topics(set)
    puts topics(set)
  end  
end

p = Parser.new("CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.1.0.pdf")
p.find_topics("a")
