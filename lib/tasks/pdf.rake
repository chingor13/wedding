desc "Generate pdf"
task :pdf => :environment do
  require 'prawn'

  class RsvpDocument
    include Prawn::View
    include Rails.application.routes.url_helpers

    attr_reader :rsvps

    def initialize(rsvps)
      @rsvps = rsvps
      @document = Prawn::Document.new(page_layout: :landscape)

      font_families["DroidSans"] = {
        normal: { file: "./DroidSans.ttf", font: "DroidSans" }
      }
    end

    def save(file)
      rsvps.each_with_index do |rsvp, i|
        create_page(rsvp)
        start_new_page unless i == rsvps.length - 1
      end
      save_as(file)
    end

    protected

    def create_page(rsvp)
      tempfile = Tempfile.new(["qrcode", ".png"], encoding: Encoding::BINARY)
      tempfile.write(rsvp.qrcode.read)
      tempfile.close

      font("DroidSans") do
        define_grid(rows: 1, columns: 2)
        grid([0,0], [0,0]).bounding_box do
          image tempfile.path
          text("To save time, we have set up a website where you can RSVP. Simply scan the above QR code with your phone or visit the following URL:")
          text("\n")
          text(rsvp.url)
          text("\n")
          text("Alternatively, if you would like to RSVP via mail, please fill out the other side and mail to:")
          text("\n")
          text("Jeff & Diana")
          text("4816 S 170th St")
          text("SeaTac, WA 98188")
        end
        grid([0,1], [0,1]).bounding_box do
          indent(20) do
            text("\n")
            text("\n")
            text("Name:  #{rsvp.name}")
            text("\n")
            text("\n")
            rectangle [0, cursor], 12, 12
            indent(20) do
              text("Yes, I can make it")
              text("\n")
              text("\n")
              text("If so, we will have ___________ of #{rsvp.max_attending}")
              text("\n")
              text("\n")
            end

            rectangle [0, cursor], 12, 12
            indent(20) { text("No, I cannot make it") }
            text("\n")
            text("\n")
            text("Notes: (dietary restrictions, etc.)")
          end
        end

        stroke do
          line [bounds.width / 2, 0], [bounds.width / 2, bounds.height]
        end
      end
    end

    def self.default_url_options
      {host: 'localhost:3000'}
    end
  end

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
