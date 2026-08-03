# soul — Claude Code instructions

## Project structure
```
index.html                  ← homepage: title "soul" + description, links to bible-verses-archive.html and prayers-archive.html inline
post.html                   ← single-post viewer (loads .txt via ?p= param)
bible-verses-archive.html   ← single page for all bible verse entries, with two anchor-based indexes (by author/book, by topic)
prayers-archive.html        ← list of prayer topics that have entries, links to each {topic}-archive.html
{topic}-archive.html        ← one page per topic, e.g. gratitude-archive.html, lists all entries for that topic
soulfavicon.png
bible/
  {book}_{chapter}-{verse}.txt   e.g. isaiah_60-22.txt
prayers/
  {topic}_{NN}.txt               e.g. gratitude_01.txt
```

There is no about.txt — its content lives directly in index.html.

## File formats

### Bible verse (bible/{book}_{chapter}-{verse}.txt)
First line: `Book Chapter:Verse | title` — book name capitalized (proper name), title lowercase unless it contains a religious reference.
```
Book Chapter:Verse | title
↳ [back to index](index.html)
↳ [back to bible verses archive](bible-verses-archive.html)
↳ [back to prayers archive](prayers-archive.html)

Verse text (NLT, verbatim in wording — but lowercase style rule below still applies to it).

---

Reflection.
```
The verse text is the literal NLT translation — never paraphrased or shortened — but still gets the lowercase style rule applied (no exception for scripture). In longer verses, break the quote onto separate lines at natural clause/sentence boundaries rather than one continuous line.

Mark every verse number with `[N]` — `post.html` renders this as a small gray `.counter`-styled span, matching the style used for the version/author notes on the archive pages. The first marker goes at the start of the text; if a quote spans multiple verses, later markers go wherever that verse begins in the NLT source, not necessarily at the start of a line (e.g. `[22] the smallest family...`).

The `---` + reflection section is optional: if there's no reflection, the file ends right after the verse text — no separator, no extra section.

### Prayer (prayers/{topic}_{NN}.txt)
First line: `topic | title` — topic lowercase (common noun, not a proper name).
```
topic | title
↳ [back to index](index.html)
↳ [back to bible verses archive](bible-verses-archive.html)
↳ [back to prayers archive](prayers-archive.html)

Content.
```

Every .txt file (bible or prayer) carries all three back-links, regardless of type. Links inside .txt files are resolved relative to post.html (which lives at the repo root), so never prefix them with `../` even though the .txt file itself lives in bible/ or prayers/.

## Formatting syntax (same engine as thoughtcapsules, no day counter)
- `!!text!!` → highlight
- `\ text` → blockquote line (each line of a quote gets its own `\ `)
- `[text](url)` → link
- `[N]` → verse-number marker, rendered as a small gray `.counter`-styled span (see bible verse format below)
- `~ text` → counter-styled line (small gray, same look as `[N]` markers and the archive-page version/author notes); links inside are still rendered as links. Uses:
  - optional source-attribution line, e.g. `~ ↳ source: [name](url)` — the name follows the lowercase rule too, even if it's a person's name (the proper-name exception does not apply here, unlike bible book names)
  - bible verses only: a mandatory topic cross-link as the very last line of the file, e.g. `~ ↳ see other verses on the same topic > [topic name](bible-verses-archive.html#topic-slug)` — placed after the source line if present, otherwise after the reflection/verse text

## Lowercase style rule
All text, everywhere (.txt content, HTML page text, titles, headings), is lowercase — including the initial letter of sentences and titles — EXCEPT:
- words referring directly to God/religion: Lord, God, Him, His, Heaven, You/Your (when addressing God directly), and similar
- proper names: book names (Isaiah, Genesis, Matthew...), people's names

Everything else, including brand names (e.g. "telegram"), sentence-initial words, and the pronoun "I" (when referring to a human, not God), is lowercase.

## Archive pages: adding a new book, topic, or prayer topic

### Bible
`bible-verses-archive.html` is a single page — no per-book or per-topic pages. It has two anchor-based indexes at the top (`↳ author` and `↳ topic`, each a `|`-separated list of `<a href="#slug">name</a>`) followed by the corresponding sections, each headed by an invisible anchor `<span id="slug"></span>Name`.

Every bible verse is assigned exactly one topic (Claude proposes it, reusing an existing one when it fits).

1. Add the new .txt file under bible/.
2. **Author/book section**: if a `<span id="{book-slug}"></span>{Book}` section already exists, insert the new entry in chapter:verse ascending order among the existing `↳ {chapter}:{verse} <a>...</a>` lines under it (biblical order within the book, not insertion date). If it's a new book, create the section (positioned in canonical biblical order, Genesis → Revelation) and add `<a href="#{book-slug}">{Book}</a>` to the `↳ author` index line, in the same canonical position.
3. **Topic section**: if a `<span id="{topic-slug}"></span>{topic}` section already exists, insert the new entry as the first `↳ {Book} {chapter}:{verse} <a>...</a>` line under it (newest first — note the book name IS included here, since a topic section spans multiple books). If it's a new topic, create the section (positioned alphabetically among topic sections) and add `<a href="#{topic-slug}">{topic}</a>` to the `↳ topic` index line, alphabetically.
4. Add the `~ ↳ see other verses on the same topic > [...]` line to the .txt file (see Formatting syntax above).

### Prayers
1. Add the new .txt file under prayers/.
2. If the topic already has a `{topic}-archive.html` page: insert the new entry as the first `↳` line (newest first).
3. If it's a new topic: create `{topic}-archive.html` (same template as gratitude-archive.html, with the two back-links to index.html and prayers-archive.html) and add a `↳ <a href="{topic}-archive.html">{topic}</a>` line to prayers-archive.html, in alphabetical order.

## Entry link format
- Bible, author/book section: `↳ {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Bible, topic section: `↳ {Book} {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Prayers ({topic}-archive.html): `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a>`

## Naming conventions
- Bible files: lowercase book name + `_` + chapter-verse, e.g. `isaiah_60-22.txt`, `romans_8-28.txt`.
- Prayer files: lowercase topic + `_` + two-digit sequence number (per topic), e.g. `gratitude_01.txt`, `gratitude_02.txt`, `entrusting_01.txt`.
- Topic is always the first word of the prayer's first line (before ` | `).
- Book is always the text before the chapter:verse in the bible verse's first line.
- Archive page files: prayers use `{topic-slug}-archive.html`, all lowercase, e.g. `gratitude-archive.html`. Bible verses have no per-book/topic archive files — everything lives in `bible-verses-archive.html` via anchors, slugs being the lowercased book/topic name with spaces and `&` replaced by `-` (e.g. `rest-stillness`).
