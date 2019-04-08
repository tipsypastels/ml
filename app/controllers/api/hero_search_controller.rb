class Api::HeroSearchController < ApplicationController
  def search
    puts "\n\n\n#{params}\n\n\n"
    text = params[:text]

    users = User.where("username LIKE \"#{text}%\"").limit(5)
    
    users_json = JSON.parse(ActiveModel::Serializer::CollectionSerializer
      .new(users, each_serializer: UserSerializer)
      .to_json)

    render json: { results: users_json }
  end
end