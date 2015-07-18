require_relative 'parser'

describe Scrub do
  before do
    
    cur_dir = File.dirname(__FILE__)

    @sample_document = "#{cur_dir}/CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.0.0.txt"
    

  end

  it "should open a text file" do
    doc = Scrub.new
    expect(doc.open_file(@sample_document).class).to eq(File)
  end

  it "should find a line of text starting with 1.1.1" do
    doc = Scrub.new
    doc.start
  end

end