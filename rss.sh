#!/bin/bash

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
echo "<rss version=\"2.0\">"
echo "<channel>"
echo "<title>Rajzfilmfigurák</title>"
echo "<link>http://rajzfilmfigurak.hu</link>"

while read -r line
do
  # End of a post
  if [[ `echo $line | grep '<a href'` ]]
  then
    echo "<item>"
    echo "<title>$title</title>"
    echo "<link>http://rajzfilmfigurak.hu/#$anchor</link>"
    echo "<description><![CDATA["
    echo "$content"
    echo "]]></description>"
    echo "</item>"

    get_content=0
  fi

  # Getting content between header and end
  if [[ $get_content -eq 1 ]]
  then
    content="$content $line"
  fi

  # Beginning of a post, starts with a named anchor
  if [[ `echo $line | grep '<a name='` ]]
  then
    anchor=`echo $line | sed 's/.*<a name="\([^"]*\).*/\1/'`
  fi

  # Title line, marked with H2 header
  if [[ `echo $line | grep '<h2>'` ]]
  then
    title=`echo $line | sed 's/<h2>\([^<]*\)<\/h2>/\1/'`
    content=''
    get_content=1
  fi
done < index.html

echo "</channel>"
echo "</rss>"
