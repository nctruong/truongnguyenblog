class Post < ApplicationRecord
  has_many :comments, :dependent => :destroy
  belongs_to :user

  validates_presence_of :title
  validates_presence_of :body

  # below code is for sunspot search
  # searchable do
  #   text :title, :body
  #   text :comments do
  #     comments.map { |comment| comment.body }
  #   end
  #
  #   # boolean :featured
  #   # integer :blog_id
  #   # integer :author_id
  #   # integer :category_ids, :multiple => true
  #   # double  :average_rating
  #   # time    :published_at
  #   # time    :expired_at
  #
  #   string  :sort_title do
  #     title.downcase.gsub(/^(an?|the)/, '')
  #   end
  # end
end
