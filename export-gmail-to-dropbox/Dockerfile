FROM python:3-alpine

ADD install.sh install.sh
RUN sh install.sh && rm install.sh

ENV HOST "imap.gmail.com"
ENV USERNAME ""
ENV PASSWORD ""
ENV FOLDER ""
ENV DROPBOX_ACCESS_TOKEN ""
ENV SCHEDULE ""

ADD run.sh run.sh
ADD main.sh main.sh

CMD ["sh", "run.sh"]
