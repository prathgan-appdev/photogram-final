class Like < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "fan_id" })
  belongs_to(:photo, { :required => true, :class_name => "Photo", :foreign_key => "photo_id", :counter_cache => true })
  validates(:photo_id, { :presence => true })
  validates(:photo_id, { :uniqueness => { :scope => ["fan_id"], :message => "already liked" } })
  validates(:fan_id, { :presence => true })
end
