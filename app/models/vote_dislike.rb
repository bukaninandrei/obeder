class VoteDislike < Vote
  def set_defaults
    self.vote_type = false
  end

  default_scope { where(vote_type: false) }
  belongs_to :voteable, polymorphic: true, counter_cache: 'dislikes_count'
end
