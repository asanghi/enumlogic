require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Enumlogic" do
  it "should have a constant" do
    Computer.enum :kind, ["apple", "dell", "hp"], :namespace => true
    Computer::KINDS.should == ["apple", "dell", "hp"]
  end
  
  it "constant should always return an array" do
    hash = ActiveSupport::OrderedHash.new
    hash["apple"] = "Apple"
    hash["dell"] = "Dell"
    hash["hp"] = "HP"
    
    Computer.enum :kind, hash, :namespace => true
    Computer::KINDS.should == ["apple", "dell", "hp"]
  end
  
  it "should create a class level options method" do
    Computer.enum :kind, ["apple", "dell", "hp"]
    Computer.kind_options.should == {"apple" => "apple", "dell" => "dell", "hp" => "hp"}
  end
  
  it "should create a class level options method for hashes" do
    Computer.enum :kind, {"apple" => "Apple", "dell" => "Dell", "hp" => "HP"}
    Computer.kind_options.should == {"Apple" => "apple", "Dell" => "dell", "HP" => "hp"}
  end
  
  it "should create key methods" do
    Computer.enum :kind, ["apple", "dell", "hp"]
    c = Computer.new(:kind => "apple")
    c.kind_key.should == :apple
  end
  
  it "should create key methods for hashes" do
    Computer.enum :kind, {"apple" => "Apple", "dell" => "Dell", "hp" => "HP"}
    c = Computer.new(:kind => "apple")
    c.kind_key.should == :apple
  end
  
  it "should create text methods" do
    Computer.enum :kind, {"apple" => "Apple", "dell" => "Dell", "hp" => "HP"}
    c = Computer.new(:kind => "hp")
    c.kind_text.should == "HP"
  end
  
  it "should create text methods for hashes" do
    Computer.enum :kind, {"apple" => "Apple", "dell" => "Dell", "hp" => "HP"}
    c = Computer.new(:kind => "hp")
    c.kind_text.should == "HP"
  end
  
  it "should create boolean methods" do
    Computer.enum :kind, ["apple", "dell", "hp"]
    c = Computer.new(:kind => "apple")
    c.should be_apple
  end
  
  it "should namespace boolean methods" do
    Computer.enum :kind, ["apple", "dell", "hp"], :namespace => true
    c = Computer.new(:kind => "apple")
    c.should be_apple_kind
  end
  
  it "should validate inclusion" do
    Computer.enum :kind, ["apple", "dell", "hp"]
    c = Computer.new
    c.kind = "blah"
    c.should_not be_valid
    c.errors[:kind].should include("kind is not included in the list")
  end
end
