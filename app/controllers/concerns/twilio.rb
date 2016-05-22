module Twilio
  extend ActiveSupport::Concern

  def set_header
    response.headers['Content-Type'] = 'text/xml'
  end

  def render_twiml(response)
    render text: response.text
  end

  def send_message(phone_number, message, attachment_url = nil)
    begin
      @twilio_number = ENV['TWILIO_NUMBER']
      @client        = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

      settings_hash = {
          from:      @twilio_number,
          to:        phone_number,
          body:      message,
      }

      settings_hash[:media_url] = attachment_url if attachment_url

      message = @client.account.messages.create(settings_hash)
      puts message.to
      true
    rescue
      false
    end
  end

  def send_contact_info(phone_number)
    send_message(phone_number, 'Please add my contact info', 'https://epgsoftware.s3.amazonaws.com/Grocery-List.vcf')
  end
end