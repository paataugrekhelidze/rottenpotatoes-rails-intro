class MoviesController < ApplicationController
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @clicked = ''
    @ratings_to_show = []
    @all_ratings = Movie.all_ratings
#     if !params[:ratings].nil?
#       params[:ratings].each { |key, value| 
#         @ratings_to_show.push(key)
#       }
#     end
#     @movies = Movie.with_ratings(@ratings_to_show)
    
    
#     if !params[:header].nil?
#       @clicked=params[:header]
#       @movies = @movies.orderby(@clicked)     
#     end
    
    
    if params[:home].nil?
      if !params[:ratings].nil?
        params[:ratings].each { |key, value| 
          @ratings_to_show.push(key)
        }
      end
      @movies = Movie.with_ratings(@ratings_to_show)
      
      if !params[:header].nil?
        @clicked=params[:header]
        @movies = @movies.orderby(@clicked)     
      end
      session[:ratings] = params[:ratings]
      session[:header] = params[:header]
    else
      if !session[:ratings].nil?
        session[:ratings].each { |key, value| 
          @ratings_to_show.push(key)
        }
      end
      @movies = Movie.with_ratings(@ratings_to_show)
      
      if !session[:header].nil?
        @clicked=session[:header]
        @movies = @movies.orderby(@clicked)     
      end
    end
    
  end
  

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
