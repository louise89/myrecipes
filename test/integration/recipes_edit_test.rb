require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @chef = Chef.create!(chefname: "testchef", email: "testchef@example.com")
    @recipe = Recipe.create(name: "vegetable sauce", description: "veggie sauce", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "chicken", description: "chicken dish")
    @recipe2.save
  end

  test "reject an invalid edit" do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: {recipe: {name: " ", description: "some description" }}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "sucessfully edit a recipe" do


  end

end
