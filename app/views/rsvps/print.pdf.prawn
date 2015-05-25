prawn_document(page_layout: :landscape) do |pdf|
  RsvpDocument.new(@rsvps, pdf).run
end