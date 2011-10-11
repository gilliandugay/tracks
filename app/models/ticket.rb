class Ticket < ActiveRecord::Base
  has_many :ticket_relations
  has_many :tickets, :through => :ticket_relations, :uniq => true

  validates_uniqueness_of :code
  validates_presence_of   :code, :title
  validates_length_of     :title, :in => 10..160

  acts_as_list :column => 'priority'

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
end