require 'uri'
require 'net/http'
require 'openssl'
require 'tocaro_webhook/payload'

module TocaroWebhook
  class Sender
    attr_accessor :url
    attr_writer   :payload


    def initialize(web_hook_key)
      @url = web_hook_url(web_hook_key)
    end

    def set_text(text)
      payload.text = text
    end

    # color is info, warning, danger, success
    def set_color(color)
      payload.color = color
    end

    def exec(options={})
      payload.text  ||= options[:text]
      payload.color ||= options[:color]

      request = Net::HTTP::Post.new(@url)
      request.body = payload.to_body

      uri = URI.parse(@url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      https.request(request)
    end

    def web_hook_url(web_hook_key)
      "https://hooks.tocaro.im/integrations/inbound_webhook/#{web_hook_key}"
    end

    def payload
      @payload ||= TocaroWebhook::Payload.new
    end

    def new_payload
      @payload = TocaroWebhook::Payload.new
    end
  end
end
