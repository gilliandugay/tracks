require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project       = projects(:tms)
    @other_project = projects(:telco)
  end

  test 'should have prefix' do
    project = Project.new(:title => 'Brand new project')
    assert !project.save
  end

  test 'should have prefix not less than 2 characters long' do
    project = Project.new(:prefix => 'B', :title => 'Brand new project')
    assert !project.save
  end

  test 'should have prefix not more than 5 characters long' do
    project = Project.new(:prefix => 'BRANDN', :title => 'Brand new project')
    assert !project.save
  end

  test 'should have unique prefix' do
    project = Project.new(:prefix => @project.prefix, :title => 'Another new project')
    assert !project.save
  end

  test 'should have title' do
    project = Project.new(:prefix => 'BNP')
    assert !project.save
  end

  test 'should have title not less than 10 characters long' do
    project = Project.new(:prefix => 'BNP', :title => 'Brand new')
    assert !project.save
  end

  test 'should have title not more than 160 characters long' do
    project = Project.new(:prefix => 'BNP', :title => 'B'*161)
    assert !project.save
  end

  test 'should have unique title' do
    project = Project.new(:prefix => 'BNP2', :title => @project.title)
    assert !project.save
  end

  test 'should upcase prefix before creating' do
    project = Project.new(:prefix => 'bnp', :title => 'Brand new project')
    old_prefix = project.prefix
    project.save
    assert_equal old_prefix.upcase, project.prefix
  end

  test 'should prevent changing prefix when updating' do
    old_prefix = @project.prefix
    assert_raise ActiveRecord::ActiveRecordError do
      @project.update_attribute :prefix, 'XXX'
    end
    assert_equal old_prefix, @project.prefix
  end

  test '#next_available_code should start with project prefix' do
    assert_match /^#{@project.prefix}/, @project.next_available_code
  end

  test '#next_available_code should return "***-001" if there are no tickets yet' do
    assert_equal 'TMS-001', @project.next_available_code
  end
end