require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Eitan", email: "eprince@example.com")
    @recipe2 = @chef.recipes.build(name: "Chicken", description: "Made with onions")
    @recipe2.save
  end
  
  test "successfully delete recipe" do
    get recipe_path(@recipe2)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe2), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe2)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
    
  end
end
