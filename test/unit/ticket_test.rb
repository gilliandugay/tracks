require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  def setup
    @project = projects(:tms)
    @ticket = Ticket.create(:title => 'New ticket', :project_id => @project.id)
  end

  test 'should_belong_to_a_project' do
    ticket = Ticket.create(:title => 'Another new ticket')
    assert !ticket.save
  end

  test 'should generate code' do
    assert_not_nil @ticket.code
  end

  test 'should generate code starting with project prefix' do
    assert_match /^#{@ticket.project.prefix}/, @ticket.code
  end

  test 'should generate unique code' do
    ticket = Ticket.create(:title => 'Another new ticket')
    assert_not_equal ticket.code, @ticket.code
  end

  test 'should have a title' do
    ticket = Ticket.new(:project_id => @project.id)
    assert !ticket.save
  end

  test 'should have a title at least 10 characters long' do
    ticket = Ticket.new(:title => 'Ticket', :project_id => @project.id)
    assert !ticket.save
  end

  test 'should have a title at most 160 characters long' do
    ticket = Ticket.new(:title => 'a'*161, :project_id => @project.id)
    assert !ticket.save
  end

  test 'should prevent changing code when updating' do
    old_code = @ticket.code
    assert_raise ActiveRecord::ActiveRecordError do
      @ticket.update_attribute :code, 'XXX'
    end
    assert_equal old_code, @ticket.code
  end

  test '#archive should archive ticket' do
    @ticket.archive
    assert_nil @ticket.priority
  end

  test '#archived? should return true when archived' do
    @ticket.archive
    assert @ticket.archived?
  end

  test '#archived? should return false when not archived' do
    assert !@ticket.archived?
  end
end