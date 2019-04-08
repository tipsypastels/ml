class ClubsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_club, only: :show
  before_action :generate_club_join_tip, only: :show
  before_action :verify_private, only: :show

  def index
    @clubs = Club.public_clubs

    if user_signed_in?
      @clubs -= current_user.clubs
    end
  end

  def show
    @topics = @club.topics.includes(:user, :tags)
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    
    if @club.save
      @club.add_user(current_user, moderator: true)
      redirect_to @club
    else
      render 'new'
    end
  end

  private

  def club_params
    params.require(:club).permit(:title, :description, :visibility, :image)
  end

  def set_club
    @club = Club.friendly.find(params[:id])
  end

  def verify_private
    redirect_to root_path unless club_permissions(@club).can_view?
  end
end