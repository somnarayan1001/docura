# Docura

Docura: PDF & image tools that run in your browser. Files are processed on your device and never uploaded.

**Use it:** https://somnarayan1001.github.io/docura/

## PDF tools
- **Merge** – combine several PDFs and drag them into order
- **Split** – custom page ranges (e.g. `1-2, 3, 4-`) or a new file every N pages, download as a .zip
- **Compress** – Less, Medium (recommended) or High compression
- **Compress to Exact Size** – pick a limit like 500 KB, and each PDF is fitted as close to it as possible without going over. Pages become images, so text can no longer be selected

## Image tools
- **Compress** – quality slider, optional resize, keep each file's format or save as WebP/JPG
- **Compress to Exact Size** – pick a limit like 50 KB, and each image is saved as JPG or WebP as close to it as possible without going over. Quality drops first, then pixel dimensions if needed
- **Convert** – mix any formats in one batch and convert them all to JPG, PNG, WebP, BMP (or AVIF where the browser supports it). Each file's real format is detected from its contents, so mislabeled files still convert correctly. You can also paste a link to an image on the web; your browser gets it directly from that website, which works only if the website allows it.

Reads JPG, PNG, WebP, GIF, BMP, TIFF, HEIC/HEIF, AVIF, ICO and SVG.

Built with [pdf-lib](https://pdf-lib.js.org/), [PDF.js](https://mozilla.github.io/pdf.js/), [JSZip](https://stuk.github.io/jszip/), [heic2any](https://github.com/alexcorvi/heic2any) and [UTIF.js](https://github.com/photopea/UTIF.js).
