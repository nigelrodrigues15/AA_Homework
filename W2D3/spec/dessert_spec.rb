require 'rspec'
require 'dessert'
require "chef"

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:dessert) { Dessert.new("dessert", 2, "baker")}
  let(:chef) { double(Chef.new("baker")) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("dessert")
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(2)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new("dessert", "two", "baker")}.to raise_error(ArgumentError)
    end

  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("chocolate")
      expect(dessert.ingredients).to include("chocolate")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredient = ["chocolate", "sugar", "syrup"]
      ingredient.each { |el| dessert.add_ingredient(el) }
      dessert.mix!
      expect(dessert.ingredients).not_to eq(ingredient)
      expect(dessert.ingredients.sort).to eq(ingredient.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(1)
      expect(dessert.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{dessert.eat(3)}.to raise_error(RuntimeError)
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(dessert.serve).to include("Baker")
    end
  end

  describe "#make_more" do
    subject(:chef) { Chef.new("baker")}
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef.bake(dessert)).to eq(400)
    end
  end
end
