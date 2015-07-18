require_relative 'parser'

describe "parser" do
  before(:all) do
    
    cur_dir = File.dirname(__FILE__)

    @redhat_pdf = "#{cur_dir}/CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.1.0.pdf"
    @ubuntu_pdf = "#{cur_dir}/CIS_Ubuntu_14.04_LTS_Server_Benchmark_v1.0.0.pdf"
  end

  describe "redhat open and parse" do
    before(:all) do
      @redhat = Parser.new(@redhat_pdf)
    end

    it "should open a text file" do
      expect(@redhat.read_pdf.class).to eq(PDF::Reader)
    end

    it "should read pages" do
      expect(@redhat.read_pages.length).to eq(173)
    end
  end

  describe "redhat find text" do
    before(:all) do
      @redhat_topics = Parser.new(@redhat_pdf).find_topics
    end

    it "should find 9 topics" do
      expect(@redhat_topics[:level_a].length).to eq(9)
    end

    it "should find a line of text starting with '1 Install Updates, Patches and Additional Security Software'" do
      expect(@redhat_topics[:level_a][0]).to eq("1 Install Updates, Patches and Additional Security Software")
    end
  end
end