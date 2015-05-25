pdf.font("DroidSans") do
  pdf.define_grid(rows: 1, columns: 2)
  pdf.grid([0,0], [0,0]).bounding_box do
    pdf.font_size(16) do
      pdf.image open(rsvp.qrcode.url), height: 200, width:200, position: 60
      pdf.text("To save time, we have set up a website where you can RSVP. Simply scan the above QR code with your phone or visit the following URL:")
      pdf.text("\n")
      pdf.text(rsvp.url)
      pdf.text("\n")
      pdf.text("Alternatively, if you would like to RSVP via mail, please fill out the other side and mail to:")
      pdf.text("\n")
      pdf.text("Jeff & Diana")
      pdf.text("4816 S 170th St")
      pdf.text("SeaTac, WA 98188")
      pdf.text("\n")
      pdf.text("\n")
      pdf.font_size(22) do
        pdf.text("Please reply by July 1, 2015")
      end
    end
  end
  pdf.grid([0,1], [0,1]).bounding_box do
    pdf.font_size(20) do
      pdf.indent(20) do
        pdf.text("\n")
        pdf.text("\n")
        pdf.text("Name:  #{rsvp.name}")
        pdf.text("\n")
        pdf.text("\n")
        pdf.rectangle [0, pdf.cursor], 12, 12
        pdf.indent(20) do
          pdf.text("Yes, I can make it")
          pdf.text("\n")
          pdf.text("\n")
          pdf.text("If so, we will have ___________ of #{rsvp.max_attending}")
          pdf.text("\n")
          pdf.text("\n")
        end

        pdf.rectangle [0, pdf.cursor], 12, 12
        pdf.indent(20) { pdf.text("No, I cannot make it") }
        pdf.text("\n")
        pdf.text("\n")
        pdf.text("Notes: (dietary restrictions, etc.)")
      end
    end
  end

  pdf.stroke do
    pdf.line [pdf.bounds.width / 2, 0], [pdf.bounds.width / 2, pdf.bounds.height]
  end
end