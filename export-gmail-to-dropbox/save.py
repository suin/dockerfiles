#!/usr/bin/env python
import sys
import io
import os
import email
import dropbox

raw_message = sys.stdin.read()
message = email.message_from_string(raw_message)
[(subject, encode)] = email.header.decode_header(message['subject'])
subject = subject.decode(encode)
from_header = email.header.decode_header(message['from'])
if len(from_header) == 1:
    [(sender, _)] = from_header
else:
    [(sender, encode), (_, _)] = from_header
    sender = sender.decode(encode)
date = email.utils.parsedate_to_datetime(message['date'])
filename = '%s (%s) %s.eml' % (date.strftime("%Y%m%d %H%M%S"), sender, subject)
print('%s: %s: %s' % (date, sender, subject))
# with open('emails/' + filename, 'w') as f: f.write(raw_message) # Save as a file
client = dropbox.client.DropboxClient(os.environ['DROPBOX_ACCESS_TOKEN'])
response = client.put_file(filename, io.StringIO(raw_message))
