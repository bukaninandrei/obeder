module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :vote_likes, foreign_key: :voteable_id, counter_cache: true
    has_many :vote_dislikes, foreign_key: :voteable_id, counter_cache: true

    def rating
      self.likes_count - self.dislikes_count
    end

    def liked(voter)
      VoteLike.create voter: voter, voteable: self
    end

    def disliked(voter)
      VoteDislike.create voter: voter, voteable: self
    end

    def liked?(voter)
      VoteLike.where(voter: voter, voteable: self).count > 0
    end

    def disliked?(voter)
      VoteDislike.where(voter: voter, voteable: self).count > 0
    end

    def unvote(voter)
      Vote.where(voteable_id: self.id, voteable_type: self.class.name, voter: voter).delete_all
      Dish.reset_counters self, :vote_likes, :vote_dislikes
    end
  end
end
