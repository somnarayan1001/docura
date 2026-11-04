# Docura change log

Newest first. Add an entry with every change, and keep "Open items" current.

## Open items

**Not yet tested**
- HEIC, TIFF and real AVIF files as input. No sample files were available.
- A real phone (only a simulated 375 px Android screen so far), including iPhone Safari.
- Compress to Exact Size with real photos and large PDFs. It was only tested with the generated sample files, and speed on big files is unknown.
- The save confirmation on the claude.ai copy with a real file.
- The original report: the 251 MB one-page PDF that failed on someone else's device. The fix was tested by forcing the failure, not on that file or device.
- Image links on the claude.ai copy. Its security rules probably block fetching other websites, so the page points people to the public site. That message was only tested by imitating the failure.

**Offered, not started (the owner hasn't decided)**
- Automatic error collection: a free Cloudflare Worker saving JSON reports to a private GitHub repository, plus scheduled checks. It needs the owner to create a Cloudflare account and a limited GitHub key. `LOG_ENDPOINT` in the code is ready and empty. Google Drive was ruled out.
- A built-in AVIF encoder, so "Convert to AVIF" works in every browser. Most browsers can't save AVIF today, so the option is hidden there. It would work on the GitHub site only.

**Known small items**
- The gear icon from the mockup was left out because there are no settings yet.
- The claude.ai copy can't show the Docura favicon, because claude.ai controls that tab icon.
- Browser storage keys still use the old `pdfpress-` prefix for tabs and errors. Harmless, and renaming would lose saved choices.

## History

### 2026-11-04: Tools first, no hero
- Owner's request: Docura is a utility, so the tools must be on the first screen without scrolling. The hero (headline, illustration, intro text) is gone. The headline stays for screen readers and search only.
- The PDF / Image switch moved into a slimmer top bar. Tool cards are now one short row with one-line descriptions and no arrow buttons. The drop zone and the feature strip are smaller.
- Once files are added, the drop zone shrinks to one row. On desktops (1000 px and wider), files sit on the left and options and the main button on the right. Long file lists scroll inside their own box, so the main button stays on screen.
- The page now scrolls to progress, results and errors when they appear, because they sit below the tool.
- Tested at 1366×650: the main button of all 7 tools is on the first screen with the sample files, and 12 files in Merge also fit. No sideways scrolling at 375 px on any tool. On the 650 px height, results and part of the feature strip can still sit below the first screen.
- `APP_VERSION` is now `2026-11-04.1`.

### 2026-11-02: Docura moved to its own repository
- The previous repository was renamed `toolhub` and is now the home page for all the owner's tools. A new `docura` repository holds this code and its full history, so the public `/docura/` address stays the same.
- GitHub no longer redirects from the old repository's links to `toolhub`, because the `docura` name is in use again.

### 2026-11-02: Compress to Exact Size
- New "Compress to Exact Size" tool in both categories (`pdfsize` and `imgsize`). Pick a target, by typing it or with a preset button, and each file lands as close to it as possible without going over.
- Images save as JPG or WebP. Quality drops first, down to 50%, then the pixel dimensions shrink. Sizes are found by real background encodes, which the button reuses.
- PDFs turn pages into JPEGs. Sample pages pick the setting, then the real file is built and measured, with up to 4 tries. Files already under the target are kept unchanged, so their text stays selectable.
- 1 KB counts as 1000 bytes here, so results also pass websites that count 1 KB as 1024 bytes. Files that can't reach the target get a clear message, and the smallest version is still offered.
- Results of the other PDF tools can continue into the new tool, and its results can continue into them.
- `APP_VERSION` is now `2026-11-02.2`.
- Owner's decision: no YouTube or Instagram downloader. It would need a server, which breaks "Nothing leaves the device", and it carries legal risk. Don't offer it again unless the owner asks.

### 2026-11-02: Convert an image from a link
- Image Convert has a new "paste a link to an image" box. The image joins the list like any other file, then converts to the chosen format.
- The browser fetches the image directly, so websites that don't allow other pages to read their images (CORS) fail. The message then offers a link to open the image, save it and add the file by hand.
- Clear messages for bad links, dead links, refusals, timeouts and links to web pages instead of images. Links never appear in status text or error reports.
- `APP_VERSION` is now `2026-11-02.1`.
- Owner's decision: websites that block this stay manual. No image proxy or Cloudflare Worker, so "Nothing leaves the device" stays literally true. Don't offer this again unless the owner asks.

### 2026-11-02: Project guide and change log
- Added `CLAUDE.md` and this file so new chats can continue the work.

### 2026-10-28: Continue with another PDF tool (`7d0b4d8`)
- Merge, Split and Compress results offer "Continue with" buttons that pass the output to another PDF tool. Split is offered only for a single file.
- PDF downloads wait 5 seconds with a countdown. Continuing cancels the download; "Download now" skips the wait.

### 2026-10-28: Repository renamed (`c7c8441`)
- `pdf-press` became `docura`. The public address is now `/docura/`, and the old `/pdf-press/` address returns 404.

### 2026-10-28: Rebrand to Docura (`97f8184`)
- New logo, favicon, dark indigo design, light/dark switch, hero, tool cards and feature strip. Added `build.sh`.
- Clicking anywhere in a drop zone opens the file picker.

### 2026-10-28: Expected output sizes (`d0c9e28`)
- Sizes per file and in total, before processing.
- Image sizes come from a real background encode. PDF Compress samples up to 3 pages at each level (within about 1% on the sample file). Merge and Split are rough.

### 2026-10-28: Image tools (`3569684`)
- New Image tools category with Compress and Convert. Formats are detected from file contents, and mixed batches are supported.
- Fixed files dropped on a drop zone being added twice.

### 2026-10-28: Large-page fix and JSON error reports (`ab08863`)
- Fixed "Cannot read properties of null (reading 'arrayBuffer')" in PDF Compress: the canvas failed on devices with lower limits. Pages are now size-capped and retried smaller.
- Anonymous JSON error reports, with copy and download buttons.

### 2026-10-28: Progress cues and auto-download (`06ec93a`)
- Spinner, striped progress bar, animated results. Results download automatically.

### 2026-10-28: First version (`f44c13b`)
- Published as PDF Press with Merge, Split and Compress (Less / Medium / High).
