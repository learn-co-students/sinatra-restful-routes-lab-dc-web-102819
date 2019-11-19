class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end
    get '/' do
        erb :index
    end

    get '/recipes' do
        @recipe = Recipe.all
        erb :recipes
    end

    get '/recipes/new' do
        erb :new
    end
    post '/recipes' do
        @new_recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])     
        erb :show
    end
    get '' do

    end

end
