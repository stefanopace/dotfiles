import sys
import os

def default(text):
    return text

def bold(text):
    return escape(text, 1, 21)

def underlined(text):
    return escape(text, 4, 24)

def italic(text):
    return escape(text, 3, 23)

def red(text):
    return escape(text, 31, 39)

def green(text):
    return escape(text, 32, 39)

def yellow(text):
    return escape(text, 33, 39)

def blue(text):
    return escape(text, 34, 39)

def magenta(text):
    return escape(text, 35, 39)

def cyan(text):
    return escape(text, 36, 39)

def arrow(text):
    return escape(text, 100, 49) + escape('', 90, 0)

def escape(text, a, b):
    return f'\e[{a}m{text}\e[{b}m'

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
        path[len(git_root_path) - 1]["color"] = green
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
        render_exit_code(exit_code) + 
        render_hostname(hostname) + 
        render_path(working_dir, inside_git_repo, branch_name, git_root_dir) + 
        render_username(whoami)
    )
)
