class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/' do
        erb :index
    end
# Create a controller action (index action) that displays all the recipes in the database.
    get '/recipes' do
        @recipe = Recipe.all
        erb :recipes
    end

# In the application_controller.rb, set up a controller action that will render a form to create a new recipe. This controller action should create and save this new recipe to the database. Routes get '/recipes/new' and post '/recipes'
    get '/recipes/new' do
        erb :new
    end
    post '/recipes' do
        @new_recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] + ' minutes')
        redirect "/recipes/#{@new_recipe.id}"
    end

# Again in the application_controller.rb, create a controller action that uses RESTful routes to display a single recipe.
    get '/recipes/:id' do
        recipe_id = params[:id]
        @recipe = Recipe.find(recipe_id)
        erb :show
    end

# Create a third controller action that uses RESTful routes and renders a form to edit a single recipe. This controller action should update the entry in the database with the changes, and then redirect to the recipe show page
    get '/recipes/:id/edit' do
        @recipe_to_edit = Recipe.find(params[:id])
        erb :edit
    end
    patch '/recipes/:id' do
        recipe_id = params[:id]
        name = params[:name]
        ingredients = params[:ingredients]
        cook_time = params[:cook_time] + " minutes"
        recipe = Recipe.find(recipe_id)
        recipe.update(name: name, ingredients: ingredients, cook_time: cook_time)
        redirect "/recipes/#{recipe.id}"
    end

# Add to the recipe show page a form that allows a user to delete a recipe. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.
    delete '/recipes/:id' do
        recipe_id = params[:id]
        Recipe.destroy(recipe_id)
        redirect "/recipes"
    end
end
