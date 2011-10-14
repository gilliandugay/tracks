require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = User.create(:email => 'test@example.com', :password => 'password')
    @ticket = Ticket.create(:title => 'Brand new ticket', :project_id => projects(:tms).id)
  end

  test 'should have a body at least 10 characters long' do
    comment = Comment.new(:body => 'Yes.', :ticket_id => @ticket.id, :user_id => @user.id)
    assert !comment.save
  end

  test 'should belong to a user' do
    comment = Comment.new(:body => 'Yes, I agree.', :ticket_id => @ticket.id)
    assert !comment.save
  end

  test 'should belong to a ticket' do
    comment = Comment.new(:body => 'Yes, I agree.', :user_id => @user.id)
    assert !comment.save
  end
end