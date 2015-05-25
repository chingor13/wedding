  class RsvpDocument
    include Prawn::View

    attr_reader :rsvps

    def initialize(rsvps, document = nil)
      @rsvps = Array(rsvps)
      @document = document || Prawn::Document.new(page_layout: :landscape)

      font_families["DroidSans"] = {
        normal: { file: "./DroidSans.ttf", font: "DroidSans" }
      }
    end

    def save(file)
      run
      save_as(file)
    end

    def run
      return true if @ran

      rsvps.each_with_index do |rsvp, i|
        puts "creating page #{i}"
        create_page(rsvp)
        start_new_page unless i == rsvps.length - 1
      end

      @ran = true
    end

    protected

    def create_page(rsvp)
      font("DroidSans") do
        define_grid(rows: 1, columns: 2)
        grid([0,0], [0,0]).bounding_box do
          font_size(16) do
            image open(rsvp.qrcode.url), height: 200, width:200, position: 60 rescue nil
            text("To save time, we have set up a website where you can RSVP. Simply scan the above QR code with your phone or visit the following URL:")
            text("\n")
            text(rsvp.url)
            text("\n")
            text("Alternatively, if you would like to RSVP via mail, please fill out the other side and mail to:")
            text("\n")
            text("Jeff & Diana")
            text("4816 S 170th St")
            text("SeaTac, WA 98188")
            text("\n")
            text("\n")
            font_size(22) do
              text("Please reply by July 1, 2015")
            end
          end
        end
        grid([0,1], [0,1]).bounding_box do
          font_size(20) do
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
        end

        stroke do
          line [bounds.width / 2, 0], [bounds.width / 2, bounds.height]
        end
      end
    end

  end