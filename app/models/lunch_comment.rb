# coding: utf-8

class LunchComment < ActiveRecord::Base
  belongs_to :rating
  belongs_to :lunch
  
  attr_accessible :name, :text, :lunch_id, :rating_id
  after_save :checkDummyComment
  
  def rating_name
    if self.rating_id == 0
      return '未評価'
    else
      '評価 ' + self.rating.name
    end
  end
  
  def checkDummyComment
    if !(self.lunch.nil?)
      self.lunch.removeDummy()
    end
  end
end
