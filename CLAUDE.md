# Docura: project guide

Docura is a free set of PDF and image tools that run entirely in the visitor's browser. Files are never uploaded, and there is no server.

Read this file and `CHANGELOG.md` before changing anything. Add an entry to `CHANGELOG.md` with every change.

## Links

| What | Where |
|---|---|
| Public site (GitHub Pages) | https://somnarayan1001.github.io/docura/ |
| Repository (public, branch `main`) | https://github.com/somnarayan1001/docura |
| Home for all the owner's tools (links to Docura) | https://somnarayan1001.github.io/toolhub/, repository `somnarayan1001/toolhub`, local folder `C:\Users\snara\Downloads\Toolhub` |
| claude.ai copy (private artifact, shared only if the owner shares it) | https://claude.ai/artifact/EWWBVgY4vKaXuqnfvxgE5H |
| Local folder | `C:\Users\snara\Downloads\PDF Press` (the old name; only the folder and `pdf-press.html` keep it) |

## Files

| File | Purpose |
|---|---|
| `pdf-press.html` | **The source. Edit this one.** All HTML, CSS and JS, with no `<html>`/`<head>` wrapper, because claude.ai adds its own. |
| `index.html` | **Generated. Never edit by hand.** The GitHub Pages site, built from `pdf-press.html` by `build.sh`. |
| `build.sh` | Wraps the source in a full document and adds the favicon links. |
| `favicon.svg`, `favicon-64.png`, `apple-touch-icon.png` | Site icons. The PNGs are rendered from the SVG. |
| `README.md` | Public description. Update it when a tool is added. |
| `CHANGELOG.md` | History of changes, plus open items. |
| `.claude/` | Local settings. Git-ignored. |

## Publishing a change

1. Edit `pdf-press.html`.
2. Run `sh build.sh`, then test (see Testing).
3. Commit `pdf-press.html`, `index.html`, `CHANGELOG.md` and anything else changed, then `git push`. Pages updates about a minute later.
4. Publish the claude.ai copy with the Artifact tool: `file_path` = `pdf-press.html`, `url` = the artifact link above. A new chat must first `read` the artifact, or the publish is refused. Leave `capabilities` out so `downloads` stays declared.

So far the owner has had each finished change pushed and published. Ask first before anything that changes the public address, such as renaming the repository, because old Pages links stop working.

## How the code is organised

Everything is inside one IIFE in the last `<script>` of `pdf-press.html`. Search for these section markers: `// ---------- error log`, `saving files`, `status`, `loading PDFs`, `sample files`, `state`, `file rows`, `results`, `passing results to another PDF tool`, `MERGE`, `SPLIT`, `COMPRESS`, `IMAGES`, `IMAGE COMPRESS`, `IMAGE CONVERT`, `EXACT SIZE`, `IMAGE LINKS`, `OUTPUT SIZE ESTIMATES`, `theme`, `wiring`.

Libraries:
- Always loaded from cdnjs: pdf-lib 1.17.1, PDF.js 3.11.174 and JSZip 3.10.1. PDF.js runs on the main thread (`pdf.worker.min.js` loaded as a plain script), so pages render through `requestAnimationFrame`.
- Loaded only when needed: heic2any 0.0.4 for HEIC, UTIF 3.1.0 and pako 2.1.0 for TIFF.
- The claude.ai copy only allows scripts from cdnjs.cloudflare.com, cdn.jsdelivr.net/npm, unpkg.com, cdn.tailwindcss.com and code.jquery.com, each pinned to an exact version. Stylesheets only from Google Fonts.

### Current tools

| Id | Category | What it does |
|---|---|---|
| `merge` | PDF | Combine PDFs, reorder by drag or arrows |
| `split` | PDF | Page ranges, or a new file every N pages; one input file |
| `compress` | PDF | Less / Medium / High (150 / 110 / 72 DPI). Pages become JPEGs, so text stops being selectable |
| `pdfsize` | PDF | Fits each PDF under a chosen size. Pages become JPEGs, and files already under the target are kept unchanged |
| `imgcompress` | Image | Quality, resize, same format / WebP / JPG |
| `imgsize` | Image | Fits each image under a chosen size as JPG or WebP. Lowers quality first, then pixel dimensions |
| `convert` | Image | Mixed formats to JPG, PNG, WebP, BMP, or AVIF where the browser can encode it. Also takes a pasted image link, fetched directly by the browser, so the website must allow it (CORS) |

### Adding a tool

Element ids follow the tool id, and the `wiring` section connects them through `Object.keys(state)`.

1. **Card:** add a `.tab` button in `<nav class="tabs">` with `id="tab-X"`, `data-tool="X"`, `data-cat="pdf"` or `"img"`, a `tone-*` class, and `hidden` if it isn't in the default category. To add a category, also add a `.cat` button, and the `data-cat` value will group the cards.
2. **Panel:** add `<section class="panel" id="panel-X" hidden>`, copying an existing one. It must contain `data-drop="X"`, `data-sample="X"`, `#in-X`, `#list-X`, `#act-X`, `#go-X`, `#note-X`, `#status-X` and `#res-X`. Optional: `#opts-X` and `#est-total-X`.
3. **Register it:** add it to `state`, `multi` and `BUSY`. Add it to `IMG_TOOLS` or `PDF_TOOLS`, which control file reading, the drop-zone hint, the 5-second countdown and the "Continue with" row. Add a label for it in `pipeRow` if it is a PDF tool.
4. **Sample:** add `samples.X`, so the tool can be tried and tested without real files.
5. **Run:** `$("#go-X").addEventListener("click", () => run("X", async () => { … await finish("X", title, outputs, zipName); }))`. Each output is `{ name, bytes: Uint8Array, mime?, pages?, before?, kept?, label? }`. `run` handles the busy button and error reports; `finish` handles the result card and download. Call `setStatus(tool, "info", msg, fraction)` for progress.
6. **Options in error reports:** add the tool's settings to the `options` lookup inside `run`.
7. **Expected sizes:** every tool shows expected output size. Add an entry to `estimators` and a case in `estimateFor` if work is needed to find the size. Otherwise write a rough size to `#note-X` in `render`, as merge and split do.
8. **Docs:** update `README.md`, this table and `CHANGELOG.md`.

### Rules that must keep holding

- **Nothing leaves the device.** No uploads, and no analytics or tracking without the owner agreeing.
- **Error reports never contain file names or contents.** `logError` strips names from the step text. Keep that true for anything new, including pasted image links, which stay out of status text and reports.
- **Never call `canvas.toBlob` without handling `null`.** Devices refuse canvases past their limits. Use `renderPageJpeg` or `renderImage`, which cap the size and retry smaller.
- **Save files only through `saveFile`.** It uses the `downloads` capability on claude.ai and a normal download elsewhere. claude.ai only allows certain extensions, and others are zipped automatically.
- **Theme:** dark by default, with light through the moon button. Colours are CSS variables on `:root` and `:root[data-theme="light"]`, so define every new colour in both.
- **Motion:** add new animations to the `prefers-reduced-motion` block.
- **Phones:** check 375 px width, with no sideways scrolling. Keep the 16px side gutter (`.gutter`).
- Bump `APP_VERSION` near the `error log` marker when releasing, so error reports show which version failed.

## Behaviour the owner asked for

- Tools first: no hero. The category switch, tool cards, drop zone, options and main button must fit the first screen on a desktop (checked at 1366×650), because this is a utility. Keep new options compact.
- Files can be added by browsing, drag and drop, or paste (Ctrl+V) anywhere on the page, which goes to the open tool. Pasted pictures named `image.png` by the browser become `pasted-image-N`.
- PDF results download automatically after a 5-second countdown. Choosing a "Continue with" tool cancels the download, and "Download now" skips the wait. Image tools download immediately.
- Several output files download as one `.zip`.
- Work in progress shows moving cues: button spinner, striped progress bar with percentage, loading placeholders, animated result card.
- Expected output size appears per file and in total before processing. Image sizes are exact (a real background encode, reused on click). PDF Compress and the PDF exact-size tool are estimated from up to 3 sample pages. Merge and Split are rough.
- Exact-size targets count 1 KB as 1000 bytes, so results also pass websites that count 1 KB as 1024 bytes. A result is only called under the target after its real size is measured. If a file can't reach the target, the result says so.
- The YouTube and Instagram downloader was considered and left out: it would need a server, which breaks "Nothing leaves the device", and it carries legal risk. Don't offer it again unless the owner asks.
- No Google Drive for logs. Errors are JSON: kept in the browser (last 20), with "Copy error details" and "Download error log (.json)" buttons. The owner chose to have people send the file by hand.
- Brand: the Docura logo and dark indigo design from the owner's mockup, minus its hero. Tool cards are solid colour cards with an arrow, as in the owner's second mockup; their colours are the `--card-*` variables. Plain language in the interface.

## Testing

Test with the sample buttons on each tool. A real browser is needed; there are no automated tests.

```bash
python -m http.server 8766 --directory "C:/Users/snara/Downloads/PDF Press"
```

Then open `http://localhost:8766/index.html` in the browser pane.

- **Keep the browser pane visible.** PDF rendering stalls in a hidden pane, which looks like a hang but isn't a bug.
- **Serve the folder explicitly, as above,** and add `?v=N` to the address if an old page appears.
- To check downloads without saving files, override `HTMLAnchorElement.prototype.click` and record `this.download`.
- To imitate the device failure, override `HTMLCanvasElement.prototype.toBlob` to call back with `null`.
- Syntax check: extract the last `<script>` and run `node --check` on it.

## GitHub

The CLI is signed in on this PC as `somnarayan1001`. Commit identity is set in this repository only, using the account's noreply address.
