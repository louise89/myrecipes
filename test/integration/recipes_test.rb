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

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should list recipes" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name

  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name.capitalize, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body

  end

end
