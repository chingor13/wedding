json.name rsvp.name
json.email_address rsvp.email_address
json.has_responded rsvp.responded?
json.is_attending rsvp.attending?
json.max_attending rsvp.max_attending
json.total rsvp.total
json.qr_code rsvp.qrcode.url
json.url reply_rsvp_url(rsvp)