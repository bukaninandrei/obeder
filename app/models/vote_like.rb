class VoteLike < Vote
  def set_defaults
    self.vote_type = true
  end

  default_scope { where(vote_type: true) }
  belongs_to :voteable, polymorphic: true, counter_cache: 'likes_count'
end
