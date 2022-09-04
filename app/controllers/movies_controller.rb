class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie

    # Either choose what to include:
    # render json: movie.to_json(only: [:id, :title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director])

    # Or what to exclude:
    # render json: movie.to_json(except: [:created_at, :updated_at])

    # Include nested resource:
    # render json: post.to_json(only: [:title, :description, :id], include: [author: { only: [:name]}])

    # But! It's better to separate concerns and use a Serializer @ movie_serializer.rb
  end

  def summary
    movie = Movie.find(params[:id])
    render json: movie, serializer: MovieSummarySerializer
  end

  def summaries
    movies = Movie.all
    render json: movies, each_serializer: MovieSummarySerializer
  end
  
  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end
