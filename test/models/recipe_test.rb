require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    
    @recipe = Recipe.new(name: "vegetable", description: "good for you")
  end
  
  test "recipe should be valid" do
    
    assert @recipe.valid?
  end
  
  test "name should be valid" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "description should be valid" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description should be at least 5 characters" do
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end
  
  test "description should be at most 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  
end