import os
import re

# Input file name
input_filename = "Comments.txt"

# Ensure the file exists
if not os.path.exists(input_filename):
    print(f"Error: {input_filename} not found!")
    exit()

# Read the content of the file
with open(input_filename, "r", encoding="utf-8") as file:
    content = file.read()

# Regex to match comments enclosed in double quotes or triple quotes
comment_pattern = r'(?:"{3}([\s\S]*?)"{3}|"(.*?)")'
matches = re.findall(comment_pattern, content)

# Extract comments (handling cases with triple or single double quotes)
comments = [match[0] if match[0] else match[1] for match in matches]

# Create a directory for output
output_dir = "Extracted_Comments"
os.makedirs(output_dir, exist_ok=True)

# Write each comment to a separate file
for idx, comment in enumerate(comments, start=1):
    filename = os.path.join(output_dir, f"comment_{idx}.txt")
    with open(filename, "w", encoding="utf-8") as comment_file:
        comment_file.write(comment.strip() + "\n")

print(f"Extracted {len(comments)} comments into {output_dir}/")
