
PHONE = "+61410759473"
CHAT_FLAGS = {
    "online": "●",
    "pinned": "📌",
    "muted": "🔇",
    # chat is marked as unread
    "unread": "👻",
    # last msg haven't been seen by recipient
    "unseen": "✓",
    "secret": "🔒",
    "seen": "✓✓",  # leave empty if you don't want to see it
}
MSG_FLAGS = {
    "selected": "☑",
    "forwarded": "⏩",
    "new": "🆕",
    "unseen": "👻",
    "edited": "✒️",
    "pending": "⭕",
    "failed": "💩",
    "seen": "✓✓",  # leave empty if you don't want to see it
}
FILE_PICKER_CMD = "ranger --choosefile={file_path}"
NOTIFY_CMD = "/usr/bin/notify-send -a arigram -i "\
    "{icon_path} telegram \'{msg}\'"
EDITOR = "nvim"
