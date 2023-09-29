# color prompts
OLD_PROMPT_COLOR = "PS1='${debian_chroot:+($debian_chroot)}\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '"
NEW_PROMPT_COLOR = "PS1='\\[\\033[01;33m\\][\\D{%d-%m-%Y} \\t] \\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\] in \\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\n\\$ '"

# read the bashrc file
with open('./.bashrc', 'r', encoding='utf8') as f:
    bashrc = f.read()

# apply the changes
bashrc = bashrc.replace(OLD_PROMPT_COLOR, NEW_PROMPT_COLOR)

# write the updated bashrc file
with open('~/.bashrc', 'w', encoding='utf8') as f:
    f.write(bashrc)