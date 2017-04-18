class Vote < ApplicationRecord
  scope :likes, -> { where(vote_type: true) }
  scope :dislikes, -> { where(vote_type: false) }

  belongs_to :voter, polymorphic: true
  validates_uniqueness_of :voteable_id, scope: [:voteable_type, :voter_type, :voter_id]

  after_initialize :set_defaults

  def set_defaults
  end
end
