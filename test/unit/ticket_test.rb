require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test 'should have a code' do
    ticket = Ticket.new(:title => 'New ticket')
    assert !ticket.save
  end

  test 'should have unique code' do
    ticket = Ticket.create(:code => 'TMS-100', :title => 'New ticket')
    duplicate = Ticket.new(:code => ticket.code, :title => 'Newer ticket')
    assert !duplicate.save
  end

  test 'should have a title' do
    ticket = Ticket.new(:code => 'TMS-100')
    assert !ticket.save
  end

  test 'should have a title at least 10 characters long' do
    ticket = Ticket.new(:code => 'TMS-100', :title => 'Ticket')
    assert !ticket.save
  end

  test 'should have a title at most 160 characters long' do
    ticket = Ticket.new(:code => 'TMS-100', :title => 'a'*161)
    assert !ticket.save
  end

  test 'should be archived' do
    ticket = Ticket.create(:code => 'TMS-100', :title => 'New ticket')
    ticket.archive
    assert_nil ticket.priority
  end

  test 'archived? should return true when archived' do
    ticket = Ticket.create(:code => 'TMS-100', :title => 'New ticket')
    ticket.archive
    assert ticket.archived?
  end

  test 'archived? should return false when not archived' do
    ticket = Ticket.create(:code => 'TMS-100', :title => 'New ticket')
    assert !ticket.archived?
  end
end