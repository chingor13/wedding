desc "Generate pdf"
task :pdf => :environment do
  require 'prawn'
  require 'open-uri'
  class RsvpJson
    attr_reader :data
    def initialize(data)
      @data = OpenStruct.new(data)
    end

    def name
      data.name
    end

    def max_attending
      data.max_attending
    end

    def qrcode
      open(data.qr_code)
    end

    def url
      data.url
    end
  end

  rsvps = JSON.parse(File.read("rsvp.json")).map do |data|
    RsvpJson.new(data)
  end
  rsvps = rsvps.last(4)
  doc = RsvpDocument.new(rsvps)
  doc.save("hello.pdf")
  `open hello.pdf`
end
