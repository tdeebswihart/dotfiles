import weechat, pynotify
#slightly modified version of http://www.weechat.org/scripts/source/stable/notify.py.html/
weechat.register("noti.py", "chronode", "0.0.1", "GPL3",\
        "notifies through libnotify based on user configured params", "", "")

settings = {
        "send_hilights"  : "on",
        "send_priv_msg"  : "on",
        "nick_separator" : ": ",
        "urgency"        : "normal",
        "channels"       : "", #channels to notify on
        #"nicks"          : "", #specific nicks to watch
        "ignored_nicks"  : "", #nicks to not notify on
        }

urgencies = {
        "low" : pynotify.URGENCY_LOW,
        "normal" : pynotify.URGENCY_NORMAL,
        "critical" : pynotify.URGENCY_CRITICAL
        }

for option, defval in settings.items():
    if weechat.config_get_plugin(option) == "":
        weechat.config_set_plugin(option, defval)

hook = weechat.hook_print("", "", "", 1, "notify", "") #all messages, all buffers
pynotify.init("weechat-notipy")

def notify(data, bufp, date, tags, displayed, highlight, prefix, message):
    chan = (weechat.buffer_get_string(bufp, "short_name") or
                weechat.buffer_get_string(bufp, "name"))
    chans = [s.strip(' ') for s in weechat.config_get_plugin('channels').split(',')]
    if prefix in [s.strip(' ') for s in \
            weechat.config_get_plugin('ignored_nicks').split(',')] or prefix in weechat.info_get('irc_nick', ''):
        pass
    elif (highlight == "1" and
            weechat.config_get_plugin('send_hilights') == "on"):
        send_notification(chan, prefix +
                weechat.config_get_plugin('nick_separator') + message)

    elif (weechat.buffer_get_string(bufp, "localvar_type") == "private" and
            weechat.config_get_plugin('send_priv_msg') == "on"):
        send_notification(prefix, message)

    elif (chan in chans):
        send_notification(chan, prefix +
                weechat.config_get_plugin('nick_separator') + message)

    return weechat.WEECHAT_RC_OK

def send_notification(chan, message):
    wn = pynotify.Notification(chan, message, weechat.config_get_plugin('icon'))
    wn.set_urgency(urgencies[weechat.config_get_plugin('urgency')] or pynotify.URGENCY_NORMAL)
    wn.show()

def shutdown():
    return weechat.WEECHAT_RC_OK

