require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = Array.new(9) { ('a'..'z').to_a.sample }
  end

  def score
    @attempt = params[:attempt].downcase
    @grid = params[:grid]
    if checker(@attempt, @grid) && english_word?(@attempt)
      @response = "congratulations"
    else
      @response = "dumbfuck"
    end
  end

  def english_word?(word)
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)
  end

  def checker(guess, stuff)
    guess.chars.all? { |letter| guess.count(letter) <= stuff.count(letter) }
  end
end
