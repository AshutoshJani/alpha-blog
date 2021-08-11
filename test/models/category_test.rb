require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

    # setup function runs and gives all the other test functions the value og category so we dont need to define it everytime because as soon as a test gets over its data is scrubbed and not saved
    def setup
        @category = Category.new(name: "sport")
    end

    test "category should be valid" do
        assert @category.valid?
    end

    test "name should be present" do 
        @category.name = " "
        assert_not @category.valid?
    end

    test "name should be unique" do
        @category.save # data is saved in the test database and not the actual database
        @category2 = Category.new(name: "sport")
        assert_not @category2.valid?
    end

    test "name should not be too short" do
        @category.name = "a"
        assert_not @category.valid?
    end

    test "name should not be too long" do
        @category.name = "abcdefghijklmnopqrstuvwxyz"
        assert_not @category.valid?
    end

end