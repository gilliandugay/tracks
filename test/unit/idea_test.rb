require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "should have notes" do
    idea = Idea.new
    assert !idea.save
  end

  test "should not have blank notes" do
    idea = Idea.new(:notes => '')
    assert !idea.save
  end

  test "should have notes at least 10 characters long" do
    idea = Idea.new(:notes => "Not valid")
    assert !idea.save
  end

  test "should have notes at most 160 characters long" do
    idea = Idea.new(:notes => "a"*161)
    assert !idea.save
  end
end