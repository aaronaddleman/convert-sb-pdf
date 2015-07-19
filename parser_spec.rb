require_relative 'parser'

describe "parser" do
  before(:all) do
    
    cur_dir = File.dirname(__FILE__)

    @redhat_pdf_file = "#{cur_dir}/CIS_Red_Hat_Enterprise_Linux_7_Benchmark_v1.1.0.pdf"
    @ubuntu_pdf_file = "#{cur_dir}/CIS_Ubuntu_14.04_LTS_Server_Benchmark_v1.0.0.pdf"
  end

  describe "redhat open and parse" do
    before(:all) do
      @redhat = Parser.new(@redhat_pdf_file)
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
      @redhat_topics = Parser.new(@redhat_pdf_file).find_topics
    end

    it "should find 9 topics" do
      expect(@redhat_topics[:level_a].length).to eq(9)
    end

    

    it "should find a line of text starting with '1 Install Updates, Patches and Additional Security Software'" do
      expect(@redhat_topics[:level_a][0]).to eq("1 Install Updates, Patches and Additional Security Software")
    end

  end

  describe "redhat open and parse page range" do
    before(:all) do
      @redhat_partial = Parser.new(@redhat_pdf_file, 40..42)
      @redhat_partial_topics = @redhat_partial.find_topics
    end

    it "should only return 5 pages" do
      expect(@redhat_partial.read_pages.length).to eq(3)
    end

    it "should only have 1 topic" do
      expect(@redhat_partial_topics[:level_a].length).to eq(1)
    end

    it "should only have 1 topic matching ..." do
      expect(@redhat_partial_topics[:level_a][0]).to eq("2 OS Services")
    end
  end

  describe "print topics" do
    before(:all) do
      @redhat_all_topics = Parser.new(@redhat_pdf_file)
      @redhat_all_topics.find_topics
    end

    it "should list all topics" do
      expect(@redhat_all_topics.to_s).to eq("1 Install Updates, Patches and Additional Security Software\n2 OS Services\n3 Special Purpose Services\n4 Network Configuration and Firewalls\n5 Logging and Auditing\n6 System Access, Authentication and Authorization\n7 User Accounts and Environment\n8 Warning Banners\n9 System Maintenance")
    end
  end
end