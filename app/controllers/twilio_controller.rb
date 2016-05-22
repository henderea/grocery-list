require 'twilio-ruby'

class TwilioController < ApplicationController
  include Twilio

  after_filter :set_header

  skip_before_action :verify_authenticity_token
end
