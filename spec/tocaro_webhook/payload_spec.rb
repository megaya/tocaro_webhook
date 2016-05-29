require 'spec_helper'
require "tocaro_webhook"

describe TocaroWebhook::Payload do
  before do
    @sender = TocaroWebhook::Sender.new("")
    @payload = @sender.new_payload
  end

  describe "add_attachment" do
    it "exist attributes" do
      title = "title"
      value = "value"
      image_url = "image_url"

      @payload.add_attachment(title: title, value: value, image_url: image_url)
      attachment = @payload.attachments[0]
      expect(attachment.title).to eq title
      expect(attachment.value).to eq value
      expect(attachment.image_url).to eq image_url
    end

    it "count attachments" do
      @payload.add_attachment
      @payload.add_attachment
      expect(@payload.attachments.length).to eq 2
    end
  end
end
