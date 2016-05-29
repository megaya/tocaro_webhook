require 'json'

module TocaroWebhook
  class Payload
    attr_accessor :text, :color, :attachments

    # uri encode json object
    def to_body
      "payload=" + URI.encode(to_json_string)
    end

    def to_h
      { text: text, color: color, attachments: attachments.to_a }
    end

    def text
      @text ||= ""
    end

    def color
      @color ||= "info"
    end

    def add_attachment(options={})
      attachments.add(options)
    end

    def attachments
      @attachments ||= Attachments.new
    end

    private

      def to_json_string
        to_h.to_json.to_s
      end

      class Attachments < Array
        def add(options={})
          self << Attachment.new(options)
        end

        def to_a
          self.map { |attachment| attachment.to_attributes_array }
        end

        class Attachment
          attr_accessor :title, :value, :image_url

          def initialize(options={}, &block)
            @title     = options[:title]     || ""
            @value     = options[:value]     || ""
            @image_url = options[:image_url] || ""
          end

          def to_attributes_array
            { title: @title, value: @value, image_url: @image_url }
          end
        end
      end

  end
end
