class Api::VotesController < Api::ApplicationController
  def dish
    dish = Dish.find(params[:id])
    dish.unvote(current_user)

    if params[:vote_type] > 0
      dish.liked(current_user)
    else
      dish.disliked(current_user)
    end

    dish.reload
    render json: { rating: dish.rating }
  end

  private

  def vote_params
    params.require(:vote).permit(:id, :vote_type)
  end
end
