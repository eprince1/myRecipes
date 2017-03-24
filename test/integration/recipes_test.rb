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
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "should show recipes" do
    get recipe_path(@recipe2)
    assert_template 'recipes/show'
    assert_match @recipe2.name, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
  
  test "create new recipe" do
    get new_recipe_path
  end
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
  end
  
end
