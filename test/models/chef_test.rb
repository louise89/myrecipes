require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "louise", email: "louise@myrecipes.com",
       password: "password", password_confirmation: "password")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chefname should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end

  test "chefname shouldn't be less than 5 characters" do
    @chef.chefname = "a" * 3
    assert_not @chef.valid?
  end

  test "chefname shouldn't be more than 50 characters" do
    @chef.chefname = "a" * 51
    assert_not @chef.valid?
  end

  test "description should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end

  test "email shouldn't be less than 5 characters" do
    @chef.email = "a" * 3
    assert_not @chef.valid?
  end

  test "email shouldn't be more than 50 characters" do
    @chef.email = "a" * 51
    assert_not @chef.valid?
  end

  test "email should accept email format" do
    valid_emails = %w[user@example.com TEST@gmail.com M.First@yahoo.ca john+smith@co.uk.org]
     valid_emails.each do |valids|
     @chef.email = valids
     assert @chef.valid?, "#{valids.inspect} should be valid"
   end
  end

  test "email should accpet correct formats" do
    @chef.email = "user@example.com"
    assert @chef.valid?
  end


  test "email should reject invalid formats" do
    @chef.email = "www.myrecipes.com"
    assert_not @chef.valid?
  end

  test "email should be unique" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be case insensitive" do
    @chef.email = "LoUiSe@MyRecipes.com"
    assert @chef.valid?
  end

  test "email should be lower case before hitting db" do
    mixed_email = "LoUiSe@MyRecipes.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end

  test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "test"
    assert_not @chef.valid?
  end

  test "associated recipes should be destroyed" do
    @chef.save
    @chef.recipes.create!(name: "testing destroy", description: "testing destroy function")
    assert_difference 'Recipe.count', -1 do
      @chef.destroy
    end
  end

end
