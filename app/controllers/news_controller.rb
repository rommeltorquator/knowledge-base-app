class NewsController < ApplicationController
  def index
    @news = Newsfeed.new
    @team_news = Newsfeed.where(team_id: current_member.team_id).all if member_signed_in?
    @team_news = Newsfeed.where(team_id: current_admin.team_id).all if admin_signed_in?
  end

  def create
    @news = Newsfeed.new(newsfeed_params)
    @news.user_id = current_member.id if member_signed_in?
    @news.team_id = current_member.team_id if member_signed_in?
    @news.user_id = current_admin.id if admin_signed_in?
    @news.team_id = current_admin.team_id if admin_signed_in?

    if @news.save
      redirect_to news_index_path, notice: 'Your news has been successfully created!'
    else
      redirect_to news_index_path, alert: 'Invalid entry!'
    end
  end

  def destroy
    @newsfeed = Newsfeed.find(params[:id])
    @newsfeed.destroy
    redirect_to news_index_path, notice: 'News has been successfully deleted'
  end

  private

  def newsfeed_params
    params.require(:newsfeed).permit(:body)
  end
end
