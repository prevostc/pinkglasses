require 'spec_helper'

describe Item do
  describe ".new" do
    it "creates a new item with at least a picture" do
      item = Factory(:item)
      assert_not_equal item.image_path, nil
      assert_not_equal item.image_path, ""
    end
    
    it "creates a new item with a score equal to zero" do
      item = Factory(:item)
      assert_equal item.score, 0
    end 
    
    it "creates a new item with a unique image path" do
      item = Factory(:item)
      assert_equal Item.find_by_image_path(item), nil
    end
  end
end