prawn_document(page_layout: :landscape) do |pdf|
  RsvpDocument.new(@rsvp, pdf).run
end