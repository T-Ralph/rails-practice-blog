require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "category should have name" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "category name should be unique" do
    @category.save
    @category_2 = Category.new(name: "Sports")
    assert_not @category_2.valid?
  end

  test "category name should be within length" do
    @category.name = "Sports" * 50
    assert_not @category.valid?
    @category.name = "S"
    assert_not @category.valid?
  end

end