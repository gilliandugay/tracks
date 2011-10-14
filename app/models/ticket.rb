class Ticket < ActiveRecord::Base
  has_many   :ticket_relations
  has_many   :tickets, :through => :ticket_relations, :uniq => true
  has_many   :comments, :order => 'created_at DESC'
  belongs_to :project

  validates_uniqueness_of :code
  validates_presence_of   :title
  validates_length_of     :title, :in => 10..160
  validates_presence_of   :project

  before_create :generate_code

  acts_as_list :column => 'priority', :scope => :project

  delegate :prefix, :to => :project

  attr_readonly :code

  def archive
    remove_from_list
  end

  def archived?
    !in_list?
  end

  class << self
    def archived
      where(:priority => nil)
    end

    def active
      where('priority IS NOT NULL')
    end
  end

  private

  def generate_code
    self.code = project.next_available_code
  end
end