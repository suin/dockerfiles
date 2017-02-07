# export-gmail-to-dropbox

A Docker image to export emails from Gmail to Dropbox.

* Supports periodic exporting; for example, daily, hourly and so on.
* Only exports email in a specific label/folder.
* Also support non-gmail email servers.


## Basic Usage

### Run Once

```
docker run \
  --rm \
  -e USERNAME=YOUR_USER_NAME@gmail.com \
  -e PASSWORD="YOUR_PASSWORD" \
  -e FOLDER="YOUR_LABEL" \
  -e DROPBOX_ACCESS_TOKEN="YOUR_TOKEN" \
  suin/export-gmail-to-dropbox
```

### Run Hourly

```
docker run \
  --name export_gmail \
  -d \
  --restart=always \
  --log-opt max-size=1m \
  --log-opt max-file=5 \
  -e USERNAME=YOUR_USER_NAME@gmail.com \
  -e PASSWORD="YOUR_PASSWORD" \
  -e FOLDER="YOUR_LABEL" \
  -e DROPBOX_ACCESS_TOKEN="YOUR_TOKEN" \
  -e SCHEDULE=@hourly \
  suin/export-gmail-to-dropbox
```

## Environment variables

- `HOST` IMAP server host name (default: imap.gmail.com)
- `USERNAME` Gmail/email username *required*
- `PASSWORD` Gmail/email password *required*
- `FOLDER` Label in Gmail *required*
- `MYSQL_PASSWORD` the mysql password *required*
- `DROPBOX_ACCESS_TOKEN` your Dropbox API access token *required*
- `SCHEDULE` backup schedule time, see explainatons below
- `TZ` Timezon setting (default: UTC)

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).

## How to Get Dropbox API Token

Visit [the Dropbox app creation page](https://www.dropbox.com/developers/apps/create), and fill following fields in there.

1. Choose an API ... Dropbox API
2. Choose the type of access you need ... App folder
3. Name your app ... Your favorite name. This will be a folder name.

![](https://cdn.suin.io/542/1.png)

Once an application have created, you should press "Generate" button to generate your access token:

![](https://cdn.suin.io/542/2.png)

## Trouble Shooting

### Gmail says "Web login required"

If you got error message "Web login required" with output like followings, you will have to enable "Allow less secure apps" On in your Google settings.

```
fetchmail: IMAP> A0002 LOGIN "YOUR_USER_NAME@gmail.com" *
fetchmail: IMAP< * NO [WEBALERT https://accounts.google.com/signin/continue?sarp=1&scc=1&plt=...] Web login required.
fetchmail: IMAP< A0002 NO [ALERT] Please log in via your web browser: https://support.google.com/mail/accounts/answer/78754 (Failure)
fetchmail: IMAP> A0003 LOGOUT
```

Go [Connected apps & sites](https://myaccount.google.com/u/2/security#connectedapps) and turn on "Allow less secure apps".
