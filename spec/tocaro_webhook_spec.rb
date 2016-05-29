require 'spec_helper'
require "tocaro_webhook"

describe TocaroWebhook do

  # keyが引数として取得できるときのみテストを実施する
  if ENV["TEST_TOCARO_WEB_HOOK_KEY"]
    describe "send message" do
      before do
        @sender = TocaroWebhook::Sender.new(ENV["TEST_TOCARO_WEB_HOOK_KEY"])
      end

      it 'success send messages' do
        @sender.set_text("test")
        @sender.set_color("warning")

        @sender.payload.add_attachment(title: "title", value: "value", image_url: "")
        @sender.payload.add_attachment(title: "", value: "", image_url: "")
        @sender.payload.add_attachment(image_url: "https://dev.tocaro.im/assets/www/img_integration_inbound_webhook.png")
        @sender.payload.add_attachment(title: "title", value: "value", image_url: "https://dev.tocaro.im/assets/www/img_integration_inbound_webhook.png")
        res = @sender.exec
        expect(res.code).to eq "200"
      end

      it "detach payload" do
        payload = @sender.new_payload
        payload.add_attachment(title: "title", value: "value", image_url: "")
        @sender.payload = payload
        res = @sender.exec
        expect(res.code).to eq "200"
      end
    end
  end
end
