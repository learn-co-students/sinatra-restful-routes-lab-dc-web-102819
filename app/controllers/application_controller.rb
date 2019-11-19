class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override , true 
  end

  # code actions here!

   get '/index' do
    @recipes = Recipe.all
    erb :index
   end 

    get '/recipe/new' do
    erb :new_recipe
    end

    get '/recipe/:id' do
        recipe_id = params[:id]
        @recipe = Recipe.find(recipe_id)
        erb :show_recipe
    end

    post "/recipes" do
        name = params[:name]
        ingredients = params[:ingredients]
        cook_time = params[:cook_time]
        @recipe = Recipe.create(:name => name, :ingredients => ingredients, :cook_time => cook_time)
        redirect to "/recipe/#{@recipe.id}"
    end

   delete '/recipe/:id' do 
   @recipe = Recipe.find(params[:id])
   @recipe.delete
    redirect "/index"
   end 


end
