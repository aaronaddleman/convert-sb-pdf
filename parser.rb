require "pdf-reader"

class Parser
  attr_accessor :filename, :info, :text, :document

  def initialize(filename)
    @filename = filename
    @info = nil
    @text = []
  end

  def open_document
    self.document = PDF::Reader.new(@filename)
  end

  def info
    @info = @document.info
  end

  def text
    @document.pages.each do |page|
      @text << page.text
    end
  end

end