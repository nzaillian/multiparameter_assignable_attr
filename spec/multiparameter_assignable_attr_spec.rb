require File.expand_path('../spec_helper', __FILE__)

describe ::AModel do
  before do
  end

  it "should initialize an instance" do
    @item = AModel.new
    @item.should_not == nil
  end

  it "should accept date assignment via parameter hash" do
    @item = AModel.new

    params = {
      'start_time(1i)' => "2013",
      'start_time(2i)' => "1",
      'start_time(3i)' => "12"
    }

    @item.attributes = params

    @item.start_time.class.should == DateTime    
  end
end