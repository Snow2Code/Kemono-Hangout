import random
import termcolor
import os
import colorama
import platform
from colorama import Back, Style

def output(comment):
    """Outputs shit."""
    print(comment)

def getComments():
    """Gets directorys from "comments" in the script ran directory in."""
    return os.listdir("comments\\")

def validDirectory(directory):
    """Checks if the chosen directory is a valid comments subdirectory"""
    if os.path.exists(f"comments\\{directory}"):
        return True
    else:
        output(termcolor.colored(f"Cannot find the comment directory '{directory}'. Does it exist? To make sure you have the latest version of this tool, get it from here: https://github.com/Snow2Code/Kemono-Hangout/tree/main/src/tools/comments", "yellow"))
        output("\n")
        for comment in getComments():
            output(termcolor.colored("comment", "light_magenta"))
    print("\n")
    return False

def outputCommentContent(file):
    output("---------------------------------------------------------------------------------------------------------")
    output(file.read())
    output("---------------------------------------------------------------------------------------------------------")

output(f"""

--{termcolor.colored("Kemono Hangout Tools", "magenta")}--

🔨 {termcolor.colored("Tool: Source Code Comments", "green")} 🔨
🔨 {termcolor.colored("Tool Version: 0.1.0", "green")} 🔨
📜 {termcolor.colored("Purpose: Source Code Comments from games and other stuff to use in the Kemono Hangout Source Code, or other Source Code.", "light_green")} 📜

💚🐱 {termcolor.colored("Created by Snowy - https://github.com/Snow2Code", "light_green")} 🐱💚

🖇️ {termcolor.colored("Links", "light_magenta")} 🖇️:
{termcolor.colored("Source Code Comments Tool Github Repo - https://github.com/Snow2Code/Kemono-Hangout/tree/main/Tools/Source Comments", "light_green")}
{termcolor.colored("Kemono Hangout Github Repo - https://github.com/Snow2Code/Kemono-Hangout", "light_green")}

""")

try:
    state = ""
    commentDirectory = ""

    while True:
        if state == "":
            commentDirectory = input("Choose a directory (use help to output directories) ")

            if commentDirectory.lower() != "help":
                if validDirectory(commentDirectory):
                    state = "select comment"
            else:
                for comment in getComments():
                    output(termcolor.colored("comment", "light_magenta"))
        elif state == "select comment":
            wantReturn = input("Do you want to return back to inital state? ")
            if wantReturn in ["y", "yes", "ye"]:
                state = ""
            elif wantReturn in ["n", "no"]:
                whatComment = input("Do you want to get a random comment or all? ")
                if whatComment.lower() == "all":
                    files = os.listdir(f"comments\\{commentDirectory}")
                    for _file_ in files:
                        with open(f"comments\{commentDirectory}\{_file_}", "r", encoding="utf8") as file:
                            output("---------------------------------------------------------------------------------------------------------")
                            output(file.read())
                    output("---------------------------------------------------------------------------------------------------------")
                    break
                else:
                    randomComment = random.choice(os.listdir(f"comments\\{commentDirectory}"))
                    with open(f"comments\{commentDirectory}\{randomComment}", "r", encoding="utf8") as file:
                        outputCommentContent(file)
                        break
except KeyboardInterrupt:
    output("\nReceived keyboard interrupt. Exiting.")

# print(random.choice(os.listdir("C:\\")))


5.3