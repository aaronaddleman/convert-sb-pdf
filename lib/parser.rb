require 'pdf-reader'

class Parser
  attr_accessor :page_range, :input_pdf, :topics

  REGEXP = {
    "a" => {
      # (?:^|\n|\s)
      # ?:           Do not register as a group capture 
      # ^            Start of line
      # |            Or
      # \n           Start with new line
      # |            Or
      # \s           Start with a single space
      #
      #
      # ([1-9]\s[AC-Z][a-zA-Z,\s]*?)
      # [1-9]        Start with a number between 1 to 9
      # \s           One single space
      # [AC-Z]       Start with an A or C through Z
      # [a-zA-Z,\s]  Match a through z or A through Z or a , or a space
      # *            Repeat the previous pattern
      # ?            Be non greedy
      #
      # \n           Match a \n
      # {1}          Previous pattern stop at first match
      :level_a => Regexp.new('(?:^|\n|\s)([1-9]\s[AC-Z][a-zA-Z,\s]*?)\n{1}'),
      :level_b => Regexp.new('(?:^|\n|\s)([1-9]\.[1-9]\s[a-zA-Z,\s]*?)\n{1}')
    },
    "b" => {
      :level_a => "",
      :level_b => ""
    }
  }

  SET = "a"

  def initialize(input_pdf, page_range=nil)
    @input_pdf = input_pdf
    @page_range = page_range
  end

  def read_pdf
    PDF::Reader.new(@input_pdf)
  end

  def read_pages
    if @page_range
      read_pdf.pages[@page_range]
    else
      read_pdf.pages
    end
  end

  def topics
    level_a = []
    level_b = []


    read_pages.each do |page|
      case page.text.to_s
      when REGEXP[SET][:level_a]
        # puts $1
        level_a << $1
      when REGEXP[SET][:level_b]
        # puts $1
        level_b << $1
      end  
    end

    topics = {
      :level_a => level_a,
      :level_b => level_b
    }

  end

  def find_topics
    topics
  end

  def to_s
    self.topics[:level_a].join("\n")
  end
end

# p = Parser.new("CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.1.0.pdf")
# p.find_topics("a")
