require "json"
require "open-uri"

class GamesController < ApplicationController
  # attr_reader :letters
  def new
    @letters = []
    10.times do
      @letters << ('a'..'z').to_a.sample
    end

  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = URI.open(url).read
    word_output = JSON.parse(response)
    letters_in_word = params[:word].split('')
    @letters = params[:letters].split('')
    # raise
    letter_match = letters_in_word.all? { |letter| @letters.include?(letter) }
    if word_output["found"] && letter_match
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    elsif letter_match
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word"
    else
      @result = "Sorry but #{params[:word]} can't be built out of this grid"
    end
    # raise

  end

end
