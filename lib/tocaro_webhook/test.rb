require 'uri'
require 'json'
require 'net/http'
require 'openssl'

# http://docs.ruby-lang.org/ja/2.2.0/class/URI.html


#curl -X POST --data-urlencode 'payload={"text": "This is test message. ex link http://example.com.", "attachments": [ { "title": "This is sample title", "value": "This is sample value" } ], { "image_url": "https://dev.tocaro.im/assets/www/img_integration_inbound_webhook.png""}}' https://hooks.tocaro.im/integrations/inbound_webhook/wmere2xhws9nfuw276snmhl0sslzmdbo

uri = URI.parse('https://hooks.tocaro.im/integrations/inbound_webhook/wmere2xhws9nfuw276snmhl0sslzmdbo')

puts uri.request_uri

request = Net::HTTP::Post.new('https://hooks.tocaro.im/integrations/inbound_webhook/wmere2xhws9nfuw276snmhl0sslzmdbo')

payload = {"text" => "This is test message. ", "attachments" => [{ "title" => "This is sample title", "value" => "This is sample value", image_url: "https://dev.tocaro.im/assets/www/img_integration_inbound_webhook.png" }, { "title" => "This is sample title", "value" => "This is sample value" }, { "image_url" => "https://dev.tocaro.im/assets/www/img_integration_inbound_webhook.png"}]}.to_json

request.body = "payload=" + URI.encode(payload.to_s)

https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
https.verify_mode = OpenSSL::SSL::VERIFY_NONE

https.set_debug_output $stderr

res = https.request(request)


# 返却の中身を見てみる
puts "code -> #{res.code}"
puts "msg -> #{res.message}"
puts "body -> #{res.body}"
