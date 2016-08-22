#!/bin/bash

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
echo "<rss version=\"2.0\">"
echo "<channel>"
echo "<title>Rajzfilmfigur&aacute;k</title>"
echo "<link>http://rajzfilmfigurak.hu</link>"

while read -r line
do
  # End of a post
  if [[ `echo $line | grep '<a href'` ]]
  then
    echo "<item>"
    echo "<title>$title</title>"
    echo "<link>http://rajzfilmfigurak.hu/#$anchor</link>"
    echo "</item>"
  fi

  # Beginning of a post, starts with a named anchor
  if [[ `echo $line | grep '<a name='` ]]
  then
    anchor=`echo $line | sed 's/.*<a name="\([^"]*\).*/\1/'`
  fi

  if [[ `echo $line | grep '<h2>'` ]]
  then
    title=`echo $line | sed 's/<h2>\([^<]*\)<\/h2>/\1/'`
  fi
done < index.html

echo "</channel>"
echo "</rss>"
