class AboutController < ApplicationController
  before_action :authenticate_admin!, except: :index

  ABOUT_FILE = Rails.root.join('app/views/about/_content.html')

  def index
  end

  def edit
    @content = File.read(ABOUT_FILE)
  end

  def update
    File.write(ABOUT_FILE, params[:content])
    redirect_to about_path
  end
end
