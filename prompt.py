import sys
import os

def default(text):
    return text

def bold(text):
    return f'\e[1m{text}\e[21m'

def underlined(text):
    return f'\e[4m{text}\e[24m'

def italic(text):
    return f'\e[3m{text}\e[23m'

def red(text):
    return f'\e[31m{text}\e[39m'

def green(text):
    return f'\e[32m{text}\e[39m'

def yellow(text):
    return f'\e[33m{text}\e[39m'

def blue(text):
    return f'\e[34m{text}\e[39m'

def magenta(text):
    return f'\e[35m{text}\e[39m'

def cyan(text):
    return f'\e[36m{text}\e[39m'

def arrow(text):
    return f'\e[100m{text}\e[49m\e[90m\e[00m'

def fold_path(path, username):
    for fold in [
        ['≈', f'/home/{username}/side-projects'],
        ['*', f'/home/{username}/work-in-progress'],
        ['↓', f'/home/{username}/downloads'],
        ['µ', f'/home/{username}/projects'],
        ['•', f'/home/{username}/dotfiles'],
        ['~', f'/home/{username}'],
    ]:
        if path.startswith(fold[1]):
            return path.replace(fold[1], fold[0], 1)
    return path

def render_dir(dir):
    colored = dir["color"](dir["name"])
    styled = colored
    for style in dir["styles"]:
        styled = style(styled)

    return styled

def render_path(working_dir, inside_git_repo, branch_name, git_root_dir):
    path = ['/'] if working_dir == '/' else fold_path(working_dir, whoami).lstrip("/").split("/")
    path = [{
        "name": dir,
        "color": default,
        "styles": []
    } for dir in path]

    for i, dir in enumerate(path):
        if i % 2 == 0:
            dir["styles"].append(bold)
            dir["color"] = blue

    if inside_git_repo:
        git_root_path = fold_path(git_root_dir, whoami).lstrip("/").split("/")
        path[len(git_root_path) - 1]["color"] = yellow
        path[len(git_root_path) - 1]["styles"].append(bold)
        if branch_name == "master":
            path[len(git_root_path) - 1]["styles"].append(underlined)
    
    return ''.join(map(render_dir, path))

def render_exit_code(exit_code):
    return "" if exit_code == "0" else red(exit_code)

def render_username(whoami):
    if whoami == "stefano":
        return ""
    elif whoami == "stefanopace":
        return ""
    elif whoami == "root":
        return ":#"
    else:
        return ":??"

def render_hostname(hostname):
    if os.getenv('PROMPT_REMOVE_HOSTNAME'):
        return ""

    return magenta(hostname)

exit_code = sys.argv[1]
whoami = sys.argv[2]
hostname = sys.argv[3]
working_dir = sys.argv[4]
inside_git_repo = sys.argv[5] == "true"
branch_name = sys.argv[6]
git_root_dir = sys.argv[7]

print(
    arrow(
        render_exit_code(exit_code) + render_hostname(hostname) + render_path(working_dir, inside_git_repo, branch_name, git_root_dir) + render_username(whoami)
    )
)
