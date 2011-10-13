class Project < ActiveRecord::Base
  has_many :tickets
  has_many :project_memberships
  has_many :members, :through => :project_memberships, :uniq => true, :class_name => 'User'

  validates_uniqueness_of :prefix, :title
  validates_presence_of   :prefix, :title
  validates_length_of     :prefix, :in => 2..5
  validates_length_of     :title,  :in => 10..160

  before_create :upcase_prefix

  attr_readonly :prefix

  def next_available_code
    tickets.empty? ? "#{prefix}-001" : tickets.last.code.succ
  end

  private

  def upcase_prefix
    self.prefix.upcase!
  end
end