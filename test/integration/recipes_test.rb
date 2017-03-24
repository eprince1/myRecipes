require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Eitan", email: "eprince@example.com")
    @recipe2 = @chef.recipes.build(name: "Chicken", description: "Made with onions")
    @recipe2.save
  end
  
  test "should get recipe index" do
    get recipes_path
    assert_response :success
  end
  
  test "should show listing of recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe2.name, response.body
  end
  
end
