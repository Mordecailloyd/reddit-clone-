# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :text             not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator,
  primary_key: :id,
  foreign_key: :moderator_id,
  class_name: :User

  has_many :posts,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :Post

  has_many :postsubs,
  primary_key: :id,
  foreign_key: :sub_id,
  class_name: :PostSub



end
