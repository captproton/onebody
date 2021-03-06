# == Schema Information
# Schema version: 20080409165237
#
# Table name: setlists
#
#  id         :integer       not null, primary key
#  start      :datetime      
#  person_id  :integer       
#  created_at :datetime      
#  site_id    :integer       
#

class Setlist < ActiveRecord::Base
  has_many :performances
  has_many :songs, :through => :performances
  belongs_to :site
  
  acts_as_scoped_globally 'site_id', "(Site.current ? Site.current.id : 'site-not-set')"
end
