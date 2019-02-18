require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    try = params[:try]
    letters = params[:letters]
    if word_in_grid?(letters, try) == true
      if english_word?(try) == true
        @final_answer = "#{try} is an eglish word"
      else
        @final_answer = "Cheater, #{try} is not an english word"
      end
    else
      @final_answer = "#{try} could not be formed with #{@letters}"
    end
  end

  def english_word?(try)
    url = "https://wagon-dictionary.herokuapp.com/#{try}"
    word_test = open(url).read
    word = JSON.parse(word_test)
    word['found']
  end

  def word_in_grid?(array, try)
    a = try.upcase
    a.chars.all? { |letter| a.count(letter) <= array.count(letter) }
  end
end
