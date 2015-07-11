require_relative 'parser'

describe Parser do
  before do
    
    cur_dir = File.dirname(__FILE__)

    @sample_document = "#{cur_dir}/sample.pdf"
    @parser = Parser.new(@sample_document)

  end

  it "opens a pdf and creates a PDF Reader object" do
    @parser.open_document
    expect(@parser.document.class).to eq(PDF::Reader)
  end

  it "opens a pdf and verifies author" do
    @parser.open_document
    expect(@parser.info[:Author]).to eq("blake")
  end

  it "opens a pdf and reads information" do
    @parser.open_document
    expect(@parser.text.length).to eq(172)
  end
end