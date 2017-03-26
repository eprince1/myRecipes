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
    assert_select 'a[href=?]', edit_recipe_path(@recipe2), text: "Edit this recipe"
    assert_select 'a[href=?]', recipe_path(@recipe2), text: "Delete this recipe"
  end
  
  test "create new recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken"
    description_of_recipe = "add lots of chicken and spices"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe } }
      follow_redirect!
      assert_match name_of_recipe.capitalize, response.body
      assert_match description_of_recipe, response.body
    end
  end
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: { recipe: { name: " ", description: " " } }
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
end
