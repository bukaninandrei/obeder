module Voterable
  extend ActiveSupport::Concern

  included do
    has_many :vote_likes, foreign_key: :voter_id, counter_cache: true
    has_many :vote_dislikes, foreign_key: :voter_id, counter_cache: true

    def liked(voteable)
      VoteLike.create voter: self, voteable: voteable
    end

    def disliked(voteable)
      VoteDislike.create voter: self, voteable: voteable
    end

    def liked?(voteable)
      VoteLike.where(voter: self, voteable: voteable).count > 0
    end

    def disliked?(voteable)
      VoteDislike.where(voter: self, voteable: voteable).count > 0
    end

    def unvote(voteable)
      Vote.where(voteable_id: self.id, voteable_type: self.class.name, voter: voter).delete_all
      ApplicationRecord.reset_counters(self, :vote_likes, :vote_dislikes)
    end
  end
end
