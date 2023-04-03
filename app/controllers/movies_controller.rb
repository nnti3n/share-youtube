require "net/http"

class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(created_at: :desc)
  end

  def new
    @movie = Movie.new
  end

  def create
    begin
      movie_id = movie_url_params.match(/(?<=v=)[a-zA-Z0-9_-]+(?=&|\z)/)[0]
      uri = URI("https://www.googleapis.com/youtube/v3/videos")
      query = { part: "snippet", id: movie_id, key: ENV["GOOGLE_API_KEY"] }
      uri.query = URI.encode_www_form(query)

      # Make the request and parse the JSON response
      response = Net::HTTP.get_response(uri)
      data = JSON.parse(response.body)

      # Extract the relevant information from the response
      title = data["items"][0]["snippet"]["title"]
      description = data["items"][0]["snippet"]["description"]
      image = data["items"][0]["snippet"]["thumbnails"]["standard"]["url"]
      youtube_id = data["items"][0]["id"]

      @movie = Movie.new(title:, description:, youtube_id:, image:)
      if @movie.save
        respond_to do |format|
          format.html do
            redirect_to "/", notice: "Movie was successfully created."
          end
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    rescue => e
      flash[:movie_error] = e
      render :new, status: :unprocessable_entity
    end
  end

  def movie_url_params
    params.require(:url)
  end
end
