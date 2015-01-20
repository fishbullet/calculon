# Made for lulz only!!!
# to run app:
#
# RAILS_ENV=production rackup -p 3000
#
require "rubygems"

require 'rails'
require 'active_support/railtie'
require 'action_dispatch/railtie'
require 'action_controller/railtie'

class CalculatorApp < Rails::Application
  config.eager_load = true
  config.cache_classes = true
  config.consider_all_requests_local = true

  config.secret_key_base = 'thisismay21321awesomecalculator23131macdeforlulzonly312321'

  routes.append do
     get '/', to: 'calculator#index'
     post 'calculate', to: 'calculator#calculate'
  end
end

class ApplicationController < ActionController::Base;end

class ParseString
  class << self
    def this(string)
      token, numbers = string.scan(/\D/), string.scan(/\d+/)
      compute Hash[token: token, numbers: numbers]
    end

    private
    def compute(data = {})
      # Make white list of tokens
      if ['+', '-', '*', '/'].include? data[:token].first
	data[:numbers].first.to_i.public_send(data[:token].first.to_sym,
					      data[:numbers].last.to_i)
      else
	'bad operator'
      end
    end
  end
end

class CalculatorController < ApplicationController
  append_view_path Rails.root.join 'calculator'

  def index
    render template: 'index', layout: false
  end

  def calculate
    dirty_string = params[:input_value]
    answer = ParseString.this dirty_string
    @answer = if answer	== 'bad operator'
		'something went wrong!'
	      else
		answer
	      end
    render template: 'calculate', layout: false
  end
end

CalculatorApp.initialize!
run CalculatorApp
