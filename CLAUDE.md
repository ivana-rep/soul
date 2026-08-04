# soul — Claude Code instructions

## Project structure
```
index.html                  ← homepage: title "soul" + description, links to archive.html and all-prayers-archive.html inline
post.html                   ← single-post viewer (loads .txt via ?p= param)
archive.html                ← single page for ALL entries (verses and prayers), with two anchor-based indexes (by author/book, by topic)
all-prayers-archive.html    ← flat list of ALL prayers, newest first, independent of topic — publicly linked from archive.html
all-verses-archive.html     ← flat list of ALL verses, newest first, independent of book/topic — INTERNAL ONLY, never linked from any public page (tracks insertion order for the "read another one" loop)
soulfavicon.png
bible/
  {book}_{chapter}-{verse}.txt   e.g. isaiah_60-22.txt
prayers/
  {title-slug}.txt               e.g. you-are-all-i-need.txt
```

There is no about.txt — its content lives directly in index.html.

## File formats

### Bible verse (bible/{book}_{chapter}-{verse}.txt)
First line: `Book Chapter:Verse | title` — book name capitalized (proper name), title lowercase unless it contains a religious reference.
```
Book Chapter:Verse | title
↳ [back to index](index.html)
↳ [back to archive](archive.html)

Verse text (NLT, verbatim in wording — but lowercase style rule below still applies to it).

---

Reflection.

~ ↳ source: [name](url)

~ ↳ see other verses on the same topic > [topic](archive.html#topic-slug-verses)

> read [another](post.html?p=bible/next-file.txt) one
```
The verse text is the literal NLT translation — never paraphrased or shortened — but still gets the lowercase style rule applied (no exception for scripture). In longer verses, break the quote onto separate lines at natural clause/sentence boundaries rather than one continuous line.

Mark every verse number with `[N]` — `post.html` renders this as a small gray `.counter`-styled span. The first marker goes at the start of the text; if a quote spans multiple verses, later markers go wherever that verse begins in the NLT source, not necessarily at the start of a line (e.g. `[22] the smallest family...`).

The `---` + reflection section is optional: if there's no reflection, no separator, no extra section. The source line is optional. The topic cross-link line is mandatory. The `read another one` line is mandatory and always the very last line of the file.

### Prayer (prayers/{title-slug}.txt)
First line: `topic | title` — topic lowercase (common noun, not a proper name).
```
topic | title
↳ [back to index](index.html)
↳ [back to archive](archive.html)

Content.

---

Reflection.

~ ↳ source: [name](url)

~ ↳ see other prayers on the same topic > [topic](archive.html#topic-slug-prayers)

> read [another](post.html?p=prayers/next-file.txt) one
```
Same optionality as bible verses (reflection and source optional, topic cross-link and `read another one` mandatory and last).

Every .txt file (bible or prayer) carries both back-links (index, archive), regardless of type. Links inside .txt files are resolved relative to post.html (which lives at the repo root), so never prefix them with `../` even though the .txt file itself lives in bible/ or prayers/.

## Formatting syntax (same engine as thoughtcapsules, no day counter)
- `!!text!!` → highlight
- `\ text` → blockquote line (each line of a quote gets its own `\ `)
- `[text](url)` → link
- `[N]` → verse-number marker, rendered as a small gray `.counter`-styled span (see bible verse format above)
- `~ text` → counter-styled line (small gray, same look as `[N]` markers and the archive-page notes); links inside are still rendered as links. Uses:
  - optional source-attribution line: `~ ↳ source: [name](url)` — the name follows the lowercase rule too, even if it's a person's name (the proper-name exception does not apply here, unlike bible book names)
  - mandatory topic cross-link as the second-to-last line of the file: `~ ↳ see other verses on the same topic > [topic name](archive.html#topic-slug-verses)` (verses) or `~ ↳ see other prayers on the same topic > [topic name](archive.html#topic-slug-prayers)` (prayers) — points to the `verses`/`prayers` sub-section of that topic, not the whole section
- `> read [another](url) one` → not part of the counter-styled engine, a plain line/link. Mandatory, always the last line of every .txt file. Forms a closed loop through ALL verses (via the hidden ordering tracked in `all-verses-archive.html`) and, separately, a closed loop through ALL prayers (via `all-prayers-archive.html`) — see "The read another one loop" below.

## Lowercase style rule
All text, everywhere (.txt content, HTML page text, titles, headings), is lowercase — including the initial letter of sentences and titles — EXCEPT:
- words referring directly to God/religion: Lord, God, Him, His, Heaven, You/Your (when addressing God directly), and similar
- proper names: book names (Isaiah, Genesis, Matthew...), people's names

Everything else, including brand names (e.g. "telegram"), sentence-initial words, and the pronoun "I" (when referring to a human, not God), is lowercase.

## Archive pages: adding a new book, topic, or prayer

`archive.html` is a single page — no per-book or per-topic pages. It has two anchor-based indexes at the top (`↳ author / book` and `↳ topic`, the topic index shared between verses and prayers) followed by the corresponding sections, each headed by an invisible anchor `<span id="slug"></span>Name`. Right after the `↳ topic` index line sits `↳ [all prayers](all-prayers-archive.html)`.

Every entry (verse or prayer) is assigned exactly one topic (Claude proposes it, reusing an existing one when it fits — a topic can have only verses, only prayers, or both).

### Bible
1. Add the new .txt file under bible/.
2. **Author/book section**: if a `<span id="{book-slug}"></span>{Book}` section already exists, insert the new entry in chapter:verse ascending order among the existing `↳ {chapter}:{verse} <a>...</a>` lines under it (biblical order within the book, not insertion date). If it's a new book, create the section (positioned in canonical biblical order, Genesis → Revelation) and add `<a href="#{book-slug}">{Book}</a>` to the `↳ author / book` index line, in the same canonical position.
3. **Topic section**: within a topic block, the `verses` sub-section always comes before `prayers` when both exist, with no blank line between them. If a `<span id="{topic-slug}-verses"></span>– verses` sub-section already exists, insert the new entry as the first `↳ {Book} {chapter}:{verse} <a>...</a>` line under it (newest first — note the book name IS included here, since a topic section spans multiple books). If the topic exists but has no `verses` sub-section yet, create it right before any existing `prayers` sub-section. If it's a new topic, create the section (positioned alphabetically among topic sections) and add `<a href="#{topic-slug}">{topic}</a>` to the `↳ topic` index line, alphabetically.
4. Add the `~ ↳ see other verses on the same topic > [...]` and `> read [another](...) one` lines to the .txt file (see Formatting syntax above, and "The read another one loop" below).

### Prayers
1. Add the new .txt file under prayers/, named `{title-slug}.txt` — never `{topic}_{NN}.txt`. Verify the title slug doesn't collide with any existing prayer filename (uniqueness is checked across ALL prayers, not per topic).
2. **Topic section**: same logic as verses above, but for the `– prayers` sub-section (which comes after `verses` when both exist, no blank line between).
3. Insert the new entry as the first line of `all-prayers-archive.html` (newest first): `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a> | <a href="archive.html#{topic-slug}-prayers">{topic}</a>`.
4. Add the `~ ↳ see other prayers on the same topic > [...]` and `> read [another](...) one` lines to the .txt file.

## The "read another one" loop

Every .txt file ends with `> read [another](post.html?p=...) one`, forming a closed loop that lets a reader keep clicking forward indefinitely, in insertion order. There are two independent loops: one through all bible verses, one through all prayers — they never cross.

- **Prayers**: the loop order is the same order as `all-prayers-archive.html` (newest first, top to bottom), which is a public, linked page.
- **Verses**: the loop order is tracked by `all-verses-archive.html`, same format and same newest-first convention, but this page is **internal only** — it must never be linked from `archive.html`, `index.html`, or any other public page. It exists purely so the loop's insertion order has somewhere to live.

When adding a new entry, it's inserted at the top of the relevant flat list (making it the new "newest"). Its own `read another one` link points to whichever entry was previously first (the second-newest, going forward). The entry that was previously *last* (oldest) in that same list gets its `read another one` link rewritten to point to the new entry instead — closing the loop back onto what's now newest. Every other entry's link is untouched.

## Entry link format
- Bible, author/book section: `↳ {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Bible, topic section: `↳ {Book} {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Prayers, topic section: `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a>`
- all-prayers-archive.html / all-verses-archive.html: `↳ <a href="post.html?p={path}/{file}.txt">{title}</a> | <a href="archive.html#{slug}">{secondary}</a>` (secondary = topic for prayers, `{Book} {chapter}:{verse}` for verses)

## Naming conventions
- Bible files: lowercase book name + `_` + chapter-verse, e.g. `isaiah_60-22.txt`, `romans_8-28.txt`.
- Prayer files: lowercase title, spaces→`-`, punctuation stripped, e.g. `you-are-all-i-need.txt`. A numeric suffix (`-2`, etc.) is only a rare fallback for a genuine title collision, never the default.
- Topic is always the first word of the prayer's first line (before ` | `).
- Book is always the text before the chapter:verse in the bible verse's first line.
- Slugs (topic, book) are the lowercased name with spaces and `&` replaced by `-` (e.g. `rest-stillness`).
