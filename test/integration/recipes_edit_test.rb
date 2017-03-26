require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Eitan", email: "eprince@example.com")
    @recipe2 = @chef.recipes.build(name: "Chicken", description: "Made with onions")
    @recipe2.save
  end
  
  test "reject invalid recipe" do
    get edit_recipe_path(@recipe2)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe2), params: { recipe: { name: " ", description: "Some description" } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
  end
  
  test "successfully update a recipe" do
    get edit_recipe_path(@recipe2)
    assert_template 'recipes/edit'
    updated_name = "Updated recipe name"
    updated_description = "Updated recipe description"
    patch recipe_path(@recipe2), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe2
    assert_not flash.empty?
    @recipe2.reload

  end
  
end
