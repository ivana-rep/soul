# soul — Claude Code instructions

## Project structure
```
index.html                  ← homepage: title "soul" + description, links to archive.html and all-prayers-archive.html inline
post.html                   ← single-post viewer (loads .txt via ?p= param)
archive.html                ← single page for ALL entries (verses and prayers), with two anchor-based indexes (by author/book, by topic)
all-prayers-archive.html    ← flat list of ALL prayers, newest first, independent of topic — publicly linked from archive.html
all-verses-archive.html     ← flat list of ALL verses, newest first, independent of book/topic — publicly linked from archive.html (tracks insertion order for the "read another one" loop)
soulfavicon.png
bible/
  {book}_{chapter}-{verse}.txt   e.g. isaiah_60-22.txt
prayers/
  {title-slug}.txt               e.g. you-are-all-i-need.txt
what-is-it/
  {book-slug}.txt                 e.g. isaiah.txt — short explainer of a Bible book, one per book cited in archive.html
saints.html                 ← single page listing every saint, each behind its own anchor id, linking to their individual page
saints/
  {name-slug}.txt              e.g. francis-of-assisi.txt
saints-index.txt            ← internal-only map: one block per saint with feast day, theme tags, and current connections — see "Saints connections index" below
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

~ ↳ source: [name](url)

---

Reflection.

---

~ ↳ see other verses on the same topic > [topic](archive.html#topic-slug-verses)

~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)

~ ↳ related verses >
~ [Book Chapter:Verse | title](post.html?p=bible/file.txt)

> read [another](post.html?p=bible/next-file.txt) one

~ ↳ thought capsule | [YYYY-MM-DD](url) | title
```
The verse text is the literal NLT translation — never paraphrased or shortened — but still gets the lowercase style rule applied (no exception for scripture). In longer verses, break the quote onto separate lines at natural clause/sentence boundaries rather than one continuous line.

Mark every verse number with `[N]` — `post.html` renders this as a small gray `.counter`-styled span. The first marker goes at the start of the text; if a quote spans multiple verses, later markers go wherever that verse begins in the NLT source, not necessarily at the start of a line (e.g. `[22] the smallest family...`).

The source line is optional, and — unlike every other cross-reference line below — sits right after the verse text, before the reflection block. The `---` + reflection + `---` block is optional: if there's no reflection, neither separator appears, no extra section. Every line from immediately after the closing `---` (or immediately after the verse text, if there's no reflection) onward is counter-styled (`~` prefix), with one exception: `read another one` always stays a plain, prominent link, never counter-styled — everything else, including the thought-capsule line that now follows it, is counter-styled. The topic cross-link line is mandatory. The saint-connection line is optional — only when a saint's page genuinely links to this verse (see "Saints" workflow below) — and mirrors that link back; one line per saint if more than one connects. The `related verses` block is optional: a hand-picked, selective set of specific other verses that genuinely say something closely related — never the whole topic (that's what the topic cross-link is for) — one `~ [Ref | title](url)` line per verse, no blank line between the header and the list or between list lines. The `read another one` line is mandatory but is no longer required to be the last line of the file — the thought-capsule line(s), if any, follow it. The thought-capsule line is optional, same format already used on saint pages (`~ ↳ thought capsule | [date](url) | title`), now standard on verse/prayer files too.

### Prayer (prayers/{title-slug}.txt)
First line: `topic | title` — topic lowercase (common noun, not a proper name).
```
topic | title
↳ [back to index](index.html)
↳ [back to archive](archive.html)

Content.

~ ↳ source: [name](url)

---

Reflection.

---

~ ↳ see other prayers on the same topic > [topic](archive.html#topic-slug-prayers)

~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)

~ ↳ related prayers >
~ [title](post.html?p=prayers/file.txt)

> read [another](post.html?p=prayers/next-file.txt) one

~ ↳ thought capsule | [YYYY-MM-DD](url) | title
```
Same optionality and structure as bible verses above: source (if present) sits right after the prayer text, before the reflection; the reflection, if present, is wrapped in an opening and closing `---`; everything from there onward is counter-styled except `read another one`, which stays a plain link and is no longer required to be the file's last line. The topic cross-link (`see other prayers on the same topic`, unchanged) is mandatory. The saint-connection line is optional, same rule as bible verses. The `related prayers` block is optional and selective, same rule as `related verses` — one `~ [title](url)` line per related prayer (no reference/chapter needed here, just the title). The thought-capsule line is optional, same format as bible verses.

### Book explainer (what-is-it/{book-slug}.txt)
First line: `Book | what is it` — book capitalized (proper name), `what is it` is always fixed, lowercase, never changes.
```
Book | what is it
↳ [back to index](index.html)
↳ [back to archive](archive.html)

A few lines explaining what the book is: author/attribution, genre, Old/New Testament, main themes. Factual, concise — no reflection section, no source line, no topic cross-link, no `read another one` loop (this is a third content type, separate from verses and prayers).
```
One file per book that has at least one verse cited in `archive.html`. Not part of either "read another one" loop.

### Saint bio (saints/{name-slug}.txt)
First line: `saint | Name` — Name is the saint's canonical English name, capitalized (proper name), e.g. `Francis of Assisi`.
```
saint | Name
↳ [back to index](index.html)
↳ [back to archive](archive.html)
↳ [back to saints](saints.html)

↳ bio
feast day: Month Day
YYYY | fact
YYYY | fact

↳ quotes
\ quote text
~ — attribution

↳ what resonates with me
* point
* point

↳ connections
↳ verse: [Book Chapter:Verse — title](post.html?p=bible/file.txt)
↳ prayer: [title](post.html?p=prayers/file.txt)
↳ thought capsule | [YYYY-MM-DD](url) | title
```
Every section is headed by `↳ section name` (lowercase), with one blank line between sections and no blank line inside a section. The `bio` timeline is chronological (birth → death/canonization), not newest-first — the only place on the site where entries aren't newest-first. Quotes use the `\ ` blockquote syntax (one line per line of the quote) followed by a `~ — attribution` counter-styled line (no `↳`, since it isn't a cross-reference). `what resonates with me` uses literal `* ` bullets (same convention as thoughtcapsules), one per line, no blank lines between. `connections` links relevant verses/prayers already in the archive — chosen for genuine resonance, never forced, may be omitted entirely if nothing genuinely fits — followed by any thought capsule links already curated in the saint's Obsidian note, carried over verbatim but reordered newest-to-oldest, with the date (not the title) as the hyperlink. Every verse/prayer connection is bidirectional: the linked bible/prayer file gets a matching `~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)` line of its own (see the bible/prayer Formatting syntax above) — never link only from the saint's side.

Saint cross-linking: anywhere in a saint's file — bio, quotes, what resonates with me, connections — another saint's name appears, it's linked to that saint's page if one already exists: `[Name](post.html?p=saints/{slug}.txt)`. This runs both directions when a new saint is added — see "Saints" workflow step 7 below.

Source content comes from Obsidian, `faith/saints/{name}.md`. If the file doesn't exist yet for a saint the user wants added, remind them to run the `saint-bio` skill first — never draft the bio content from scratch.

This is a separate content type, like the book explainer: no reflection-vs-verse distinction, no source line, no topic cross-link, no "read another one" loop.

Every .txt file (bible, prayer, book explainer, or saint bio) carries both back-links (index, archive), regardless of type. Links inside .txt files are resolved relative to post.html (which lives at the repo root), so never prefix them with `../` even though the .txt file itself lives in bible/ or prayers/.

## Formatting syntax (same engine as thoughtcapsules, no day counter)
- `!!text!!` → highlight
- `\ text` → blockquote line (each line of a quote gets its own `\ `)
- `[text](url)` → link
- `[N]` → verse-number marker, rendered as a small gray `.counter`-styled span (see bible verse format above)
- `~ text` → counter-styled line (small gray, same look as `[N]` markers and the archive-page notes); links inside are still rendered as links. General rule: on verse/prayer .txt files, every line from immediately after the closing `---` of the reflection (or immediately after the verse/prayer text, if there's no reflection) onward is counter-styled — the sole exception is `> read [another](url) one`, which always stays a plain, non-counter-styled link. The source line is the one exception to the *ordering* (not the styling): it's still counter-styled, but sits right after the verse/prayer text, before the reflection block. Uses, in order:
  - optional source-attribution line: `~ ↳ source: [name](url)` — the name follows the lowercase rule too, even if it's a person's name (the proper-name exception does not apply here, unlike bible book names)
  - mandatory topic cross-link, placed after the reflection and before any saint-connection line: `~ ↳ see other verses on the same topic > [topic name](archive.html#topic-slug-verses)` (verses) or `~ ↳ see other prayers on the same topic > [topic name](archive.html#topic-slug-prayers)` (prayers) — points to the `verses`/`prayers` sub-section of that topic, not the whole section
  - optional saint-connection line, one per connected saint, placed after the topic cross-link: `~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)` — added whenever a saint's `connections` section genuinely links to this verse/prayer; keeps the link bidirectional. See "Saints" workflow below.
  - optional `related verses`/`related prayers` block, placed after the saint-connection line and before `read another one`: a header line (`~ ↳ related verses >` or `~ ↳ related prayers >`) followed by one line per related entry (`~ [Book Chapter:Verse | title](url)` for verses, `~ [title](url)` for prayers) — a hand-picked, selective set of genuinely related entries, never the full topic list (that's what the topic cross-link is for)
  - optional thought-capsule line(s), placed after `read another one`: `~ ↳ thought capsule | [YYYY-MM-DD](url) | title` — same format already used on saint pages, now standard on verse/prayer files too
- `> read [another](url) one` → not part of the counter-styled engine, a plain line/link. Mandatory on every .txt file, though no longer required to be the last line (a thought-capsule line may follow it). Forms a closed loop through ALL verses (via the ordering tracked in `all-verses-archive.html`) and, separately, a closed loop through ALL prayers (via `all-prayers-archive.html`) — see "The read another one loop" below.

## Lowercase style rule
All text, everywhere (.txt content, HTML page text, titles, headings), is lowercase — including the initial letter of sentences and titles — EXCEPT:
- words referring directly to God/religion: Lord, God, Him, His, Heaven, You/Your (when addressing God directly), and similar
- words referring to a saint: He, Him, His, and similar — same exception as God-references, anywhere on the site a saint is discussed (not only on their own page)
- proper names: book names (Isaiah, Genesis, Matthew...), people's names

Everything else, including brand names (e.g. "telegram"), sentence-initial words, and the pronoun "I" (when referring to a human, not God or a saint speaking of themself), is lowercase.

The NLT source text sometimes renders the divine name as "LORD" (small caps, representing YHWH). On this site it's always written "Lord" — never "LORD" — regardless of how the NLT source formats it. This applies going forward only; existing files are not being retroactively corrected as part of this rule.

## Archive pages: adding a new book, topic, or prayer

`archive.html` is a single page — no per-book or per-topic pages. It has two anchor-based indexes at the top (`↳ author / book` and `↳ topic`, the topic index shared between verses and prayers) followed by the corresponding sections, each headed by an invisible anchor `<span id="slug"></span>Name`. Right after the `↳ topic` index line sit `↳ [all verses](all-verses-archive.html)` and `↳ [all prayers](all-prayers-archive.html)`.

Every entry (verse or prayer) is assigned exactly one topic (Claude proposes it, reusing an existing one when it fits — a topic can have only verses, only prayers, or both).

### Bible
1. Add the new .txt file under bible/.
2. **Author/book section**: if a `<span id="{book-slug}"></span>{Book}` section already exists, insert the new entry in chapter:verse ascending order among the existing `↳ {chapter}:{verse} <a>...</a>` lines under it (biblical order within the book, not insertion date). If it's a new book, create the section (positioned in canonical biblical order, Genesis → Revelation) and add `<a href="#{book-slug}">{Book}</a>` to the `↳ author / book` index line, in the same canonical position. A new book also needs a `what-is-it/{book-slug}.txt` explainer file (see "Book explainer" above) and its section header becomes `<span id="{book-slug}"></span>{Book}<span class="counter"> / <a href="post.html?p=what-is-it/{book-slug}.txt">what is it</a></span>`.
3. **Topic section**: within a topic block, the `verses` sub-section always comes before `prayers` when both exist, with no blank line between them. If a `<span id="{topic-slug}-verses"></span>– verses` sub-section already exists, insert the new entry as the first `↳ {Book} {chapter}:{verse} <a>...</a>` line under it (newest first — note the book name IS included here, since a topic section spans multiple books). If the topic exists but has no `verses` sub-section yet, create it right before any existing `prayers` sub-section. If it's a new topic, create the section (positioned alphabetically among topic sections) and add `<a href="#{topic-slug}">{topic}</a>` to the `↳ topic` index line, alphabetically.
4. Add the `~ ↳ see other verses on the same topic > [...]` and `> read [another](...) one` lines to the .txt file (see Formatting syntax above, and "The read another one loop" below).
5. Check `saints-index.txt` for a genuinely relevant saint (its `themes` lines are the quick filter — confirm any candidate against the saint's actual `saints/{slug}.txt` before linking) — if the new verse's theme resonates with one, add a `↳ verse: [Book Chapter:Verse — title](post.html?p=bible/{file}.txt)` line to that saint's `connections` section, AND add a matching `~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)` line to the verse's own .txt file (before `read another one`) — then update that saint's `verses` line in `saints-index.txt`. Never force it — both sides of the link are added together, or neither.

### Prayers
1. Add the new .txt file under prayers/, named `{title-slug}.txt` — never `{topic}_{NN}.txt`. Verify the title slug doesn't collide with any existing prayer filename (uniqueness is checked across ALL prayers, not per topic).
2. **Topic section**: same logic as verses above, but for the `– prayers` sub-section (which comes after `verses` when both exist, no blank line between).
3. Insert the new entry as the first line of `all-prayers-archive.html` (newest first): `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a> | <a href="archive.html#{topic-slug}-prayers">{topic}</a>`.
4. Add the `~ ↳ see other prayers on the same topic > [...]` and `> read [another](...) one` lines to the .txt file.
5. Check `saints-index.txt` for a genuinely relevant saint (its `themes` lines are the quick filter — confirm any candidate against the saint's actual `saints/{slug}.txt` before linking) — if the new prayer's theme resonates with one, add a `↳ prayer: [title](post.html?p=prayers/{file}.txt)` line to that saint's `connections` section, AND add a matching `~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)` line to the prayer's own .txt file (before `read another one`) — then update that saint's `prayers` line in `saints-index.txt`. Never force it — both sides of the link are added together, or neither.

### Saints
1. Before creating anything, check `faith/saints/{name}.md` exists in Obsidian. If it doesn't, tell the user to run the `saint-bio` skill first — don't draft the bio yourself.
2. Add the new .txt file under saints/ (see "Saint bio" file format above), pulling bio/quotes/what-resonates content from the Obsidian note and thought-capsule connections from its `↳ connections` section (reordered newest-to-oldest, date as the link).
3. Check `archive.html` (or browse `bible/` and `prayers/`) for verses/prayers that genuinely resonate with this saint's life/words/what-resonates — add `↳ verse: [...]`/`↳ prayer: [...]` lines to the new saint's `connections` section. Never force it. For each one added, also add a matching `~ ↳ see saint connection > [Name](post.html?p=saints/{slug}.txt)` line to that verse/prayer's own .txt file, before its `read another one` line — the link always goes both ways.
4. Add an entry to `saints.html`, alphabetical by name: `<span id="{slug}"></span>↳ <a href="post.html?p=saints/{file}.txt">{Name}</a>`.
5. `archive.html` doesn't get a per-saint entry — only the generic `↳ <a href="saints.html">saints</a>` link, right after the `↳ <a href="all-prayers-archive.html">all prayers</a>` line, added once when the saints section is first introduced.
6. `index.html` only needs updating once, when the saints section is first introduced.
7. Cross-link with other saints: search all existing `saints/*.txt` files for mentions of the new saint's name and link them retroactively to the new page, `[Name](post.html?p=saints/{slug}.txt)`. Also check the new saint's own text (bio, quotes, what resonates, connections) for mentions of any existing saint and link those there too.
8. Add the new saint's block to `saints-index.txt` (alphabetically among the others) — slug, name, feast day, a handful of theme tags drawn from the bio/what-resonates content, and the connections just added in step 3. See "Saints connections index" above.

## The "read another one" loop

Every .txt file ends with `> read [another](post.html?p=...) one`, forming a closed loop that lets a reader keep clicking forward indefinitely, in insertion order. There are two independent loops: one through all bible verses, one through all prayers — they never cross.

- **Prayers**: the loop order is the same order as `all-prayers-archive.html` (newest first, top to bottom), which is a public, linked page.
- **Verses**: the loop order is tracked by `all-verses-archive.html`, same format and same newest-first convention. It's linked publicly from `archive.html` (`↳ all verses`).

When adding a new entry, it's inserted at the top of the relevant flat list (making it the new "newest"). Its own `read another one` link points to whichever entry was previously first (the second-newest, going forward). The entry that was previously *last* (oldest) in that same list gets its `read another one` link rewritten to point to the new entry instead — closing the loop back onto what's now newest. Every other entry's link is untouched.

## Entry link format
- Bible, author/book section: `↳ {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Bible, topic section: `↳ {Book} {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Prayers, topic section: `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a>`
- all-prayers-archive.html / all-verses-archive.html: `↳ <a href="post.html?p={path}/{file}.txt">{title}</a> | <a href="archive.html#{slug}">{secondary}</a>` (secondary = topic for prayers, `{Book} {chapter}:{verse}` for verses)
- Archive, author/book section header: `<span id="{book-slug}"></span>{Book}<span class="counter"> / <a href="post.html?p=what-is-it/{book-slug}.txt">what is it</a></span>`
- Related verses (inside a .txt file, in a `~ ↳ related verses >` block): `[Book Chapter:Verse | title](post.html?p=bible/{file}.txt)` — reference and title, never title alone
- Related prayers (inside a .txt file, in a `~ ↳ related prayers >` block): `[title](post.html?p=prayers/{file}.txt)`

## Saints connections index

`saints-index.txt` is a plain internal map, one block per saint (slug, name, feast day, a handful of theme tags, and its current verse/prayer/thought-capsule connections). It is never linked from any page, isn't part of any "read another one" loop, and the lowercase style rule doesn't apply to it — it exists purely so a saint-connection check can be done by reading this one file instead of every `saints/*.txt` in full.

Consult it instead of opening every saint file whenever checking for a genuine verse/prayer/saint connection (Bible step 5, Prayers step 5, Saints step 3 below). Whenever a connection, saint, or theme changes anywhere on the site, update `saints-index.txt` in the same commit:
- new saint added → add its block, alphabetically among the others.
- new verse/prayer connection added to a saint → append it to that saint's `verses`/`prayers` line.
- a saint's "what resonates" text changes in a way that shifts its themes → update the `themes` line.

If this file and the `saints/*.txt` files ever disagree, the `.txt` files are the source of truth — treat the mismatch as a bug to fix in the index, not in them.

## Prayer & devotion cross-links

Every prayer (all existing ones, and every future one) carries a `~ ↳ related verses >` block linking to **every** verse currently in the `prayer-devotion` topic — unlike an ordinary `related verses`/`related prayers` block, this one is automatic and exhaustive, not selective: every prayer is itself an act of the practice those verses describe, so the link always applies, never needs judgment, and is never omitted. It sits in the normal `related verses` slot (after any saint-connection/related-prayers block, before `read another one`):
```
~ ↳ related verses >
~ [Colossians 4:2 | devote yourself to prayer](post.html?p=bible/colossians_4-2.txt)
```
One line per verse in the topic, in the same order they appear under `prayer-devotion-verses` in `archive.html`.

The link is **not bidirectional**. Verses in the `prayer-devotion` topic do not list individual prayers back — they carry one fixed line instead, right after the topic cross-link line:
```
~ ↳ see all prayers > [all prayers](all-prayers-archive.html)
```

Maintenance implications:
- **New prayer added** (any topic): its `related verses` block must list every verse currently under `prayer-devotion`, per the rule above — this happens automatically as part of adding the prayer, not as a separate judgment call.
- **New verse added to the `prayer-devotion` topic**: give it the `see all prayers` line at creation, AND go back and add a line for it to the `related verses` block of every existing prayer on the site (all of them, not just `prayer-devotion`-topic prayers).
- **New verse added to any other topic**: no effect here.

## Naming conventions
- Bible files: lowercase book name + `_` + chapter-verse, e.g. `isaiah_60-22.txt`, `romans_8-28.txt`.
- Book explainer files: `what-is-it/{book-slug}.txt`, same book-slug as the bible verse files, e.g. `what-is-it/isaiah.txt`.
- Prayer files: lowercase title, spaces→`-`, punctuation stripped, e.g. `you-are-all-i-need.txt`. A numeric suffix (`-2`, etc.) is only a rare fallback for a genuine title collision, never the default.
- Saint files: canonical English name, lowercase, spaces→`-`, e.g. `francis-of-assisi.txt`.
- Topic is always the first word of the prayer's first line (before ` | `).
- Book is always the text before the chapter:verse in the bible verse's first line.
- Slugs (topic, book) are the lowercased name with spaces and `&` replaced by `-` (e.g. `rest-stillness`).
