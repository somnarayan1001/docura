#!/bin/sh
# Builds index.html (the GitHub Pages site) from pdf-press.html (the page body, also published to claude.ai).
cd "$(dirname "$0")" || exit 1
{
  cat <<'HEAD'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<meta name="theme-color" content="#0a0c16">
<link rel="icon" type="image/svg+xml" href="favicon.svg">
<link rel="icon" type="image/png" sizes="64x64" href="favicon-64.png">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<style>body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>
</head>
<body>
HEAD
  cat pdf-press.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "built index.html"
