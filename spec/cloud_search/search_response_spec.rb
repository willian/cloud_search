require "spec_helper"

describe CloudSearch::SearchResponse do
  subject { described_class.new }

  before do
    subject.body = YAML.load_file File.expand_path("../../fixtures/full.yml", __FILE__)
  end

  context "when there are results" do
    describe "#results" do
      it "list matched documents" do
        subject.results.inject([]){ |acc, i| acc << i['data']['title']}.flatten(1)
        .should == ["Star Wars: The Clone Wars", 
                    "Star Wars", 
                    "Star Wars: Episode II - Attack of the Clones", 
                    "Star Wars: Episode V - The Empire Strikes Back", 
                    "Star Wars: Episode VI - Return of the Jedi", 
                    "Star Wars: Episode I - The Phantom Menace", 
                    "Star Wars: Episode III - Revenge of the Sith"]
      end
    end

    describe "#hits" do
      it "returns number of hits" do
        subject.hits.should == 7
      end
    end

    describe "#total_entries" do
      it "returns same value from hits" do
        subject.hits.should == subject.total_entries
      end
    end

    describe "#found?" do
      it "returns true when found documents" do
        subject.should be_found
      end
    end

    describe "#items_per_page" do
      it "returns items per page" do
        subject.items_per_page.should == 10
      end
    end

    describe "#page_size" do
      it "returns number of items per page" do
        subject.items_per_page.should == subject.items_per_page
      end
    end

    describe "#offset" do
      it "returns offset" do
        subject.offset.should == 0
      end
    end
  end

  context "when there aren't results" do
    before do
      subject.body = {}
    end

    describe "#results" do
      it "list matched documents" do
        subject.results.size.should == 0
      end
    end

    describe "#hits" do
      it "returns number of hits" do
        subject.hits.should == 0
      end
    end

    describe "#found?" do
      it "returns false when not found documents" do
        subject.should_not be_found
      end
    end

    describe "#items_per_page" do
      it "returns items per page" do
        subject.items_per_page.should == 10
      end
    end

    describe "#page_size" do
      it "returns number of items per page" do
        subject.items_per_page.should == subject.items_per_page
      end
    end

    describe "#offset" do
      it "returns offset" do
        subject.offset.should == 0
      end
    end   
  end
end
