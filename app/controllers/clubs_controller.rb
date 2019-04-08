class ClubsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_club, only: :show

  def index
    @clubs = Club.public_clubs
  end

  def show
    @topics = @club.topics.includes(:user, :tags)

    if user_signed_in?
      @club.users << current_user
    end
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    @club.users << current_user

    if @club.save
      redirect_to @club
    else
      render 'new'
    end
  end

  private

  def club_params
    params.require(:club).permit(:title, :description, :visibility)
  end

  def set_club
    @club = Club.friendly.find(params[:id])
  end
end