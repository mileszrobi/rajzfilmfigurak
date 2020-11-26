#!/bin/bash

echo "<!doctype html>" > index.html
echo "<html>" >> index.html
echo "<head><meta charset=\"UTF-8\"><link rel=\"stylesheet\" href=\"github-markdown.css\"></head><body class=\"markdown-body\">" >> index.html
perl Markdown_1.0.1/Markdown.pl rajzfilmfigurak.md >> index.html
echo "</body></html>" >> index.html
