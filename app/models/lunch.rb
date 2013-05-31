class Lunch < ActiveRecord::Base
  belongs_to :genre
  belongs_to :restaurant
  has_many :lunch_comments
   
  before_save :arrangeDummyComments
  before_destroy :ensure_not_referenced_by_any_lunch_comment

    attr_accessible :name, :price, :genre_id, :restaurant_id, :withdrink, :image
    mount_uploader :image,ImageUploader
  
  # --------------------------------------------------------
  # 保管前にコメントが0件だったらダミーを挿入する
  # ダミーがあってダミー以外があればダミーを削除する
  # --------------------------------------------------------
  def arrangeDummyComments
    if lunch_comments.empty?
      self.createDummyComment()
    end
    self.removeDummy()
  end

  # --------------------------------------------------------
  # ダミーがあってダミー以外があればダミーを削除する
  # --------------------------------------------------------
  def removeDummy
    dummy = self.findDummy
    if !(dummy.nil?) && (self.lunch_comments.size() > 1)
      #self.lunch_comments.delete(dummy)
      dummy.destroy()
    end
  end
  
  # --------------------------------------------------------
  # ダミーコメントを作る
  # --------------------------------------------------------
  def createDummyComment
      newComment = self.lunch_comments.new()
      newComment.text = self.labelForDummy
      newComment.name = ' '
      newComment.rating_id = 0
      newComment.save()
  end

  # --------------------------------------------------------
  # ダミーコメント用のコメント文
  # --------------------------------------------------------
  def labelForDummy
    'no comment'
  end
  
  # --------------------------------------------------------
  # ダミーコメントを探す
  # --------------------------------------------------------
  def findDummy
    self.lunch_comments.each do | com |
      if com.text == labelForDummy
        return com
      end
    end
    return nil
  end
  
  private
  
  def ensure_not_referenced_by_any_lunch_comment
    if lunch_comments.empty?
      return true
    else
      errors.add(:base, 'This lunch has lunch_comments')
      return false
    end
  end
end
