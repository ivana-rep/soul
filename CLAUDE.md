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
Every section is headed by `↳ section name` (lowercase), with one blank line between sections and no blank line inside a section. The `bio` timeline is chronological (birth → death/canonization), not newest-first — the only place on the site where entries aren't newest-first. Quotes use the `\ ` blockquote syntax (one line per line of the quote) followed by a `~ — attribution` counter-styled line (no `↳`, since it isn't a cross-reference). `what resonates with me` uses literal `* ` bullets (same convention as thoughtcapsules), one per line, no blank lines between. `connections` links relevant verses/prayers already in the archive — chosen for genuine resonance, never forced, may be omitted entirely if nothing genuinely fits — followed by any thought capsule links already curated in the saint's Obsidian note, carried over verbatim but reordered newest-to-oldest, with the date (not the title) as the hyperlink.

Saint cross-linking: anywhere in a saint's file — bio, quotes, what resonates with me, connections — another saint's name appears, it's linked to that saint's page if one already exists: `[Name](post.html?p=saints/{slug}.txt)`. This runs both directions when a new saint is added — see "Saints" workflow step 6 below.

Source content comes from Obsidian, `faith/saints/{name}.md`. If the file doesn't exist yet for a saint the user wants added, remind them to run the `saint-bio` skill first — never draft the bio content from scratch.

This is a separate content type, like the book explainer: no reflection-vs-verse distinction, no source line, no topic cross-link, no "read another one" loop.

Every .txt file (bible, prayer, book explainer, or saint bio) carries both back-links (index, archive), regardless of type. Links inside .txt files are resolved relative to post.html (which lives at the repo root), so never prefix them with `../` even though the .txt file itself lives in bible/ or prayers/.

## Formatting syntax (same engine as thoughtcapsules, no day counter)
- `!!text!!` → highlight
- `\ text` → blockquote line (each line of a quote gets its own `\ `)
- `[text](url)` → link
- `[N]` → verse-number marker, rendered as a small gray `.counter`-styled span (see bible verse format above)
- `~ text` → counter-styled line (small gray, same look as `[N]` markers and the archive-page notes); links inside are still rendered as links. Uses:
  - optional source-attribution line: `~ ↳ source: [name](url)` — the name follows the lowercase rule too, even if it's a person's name (the proper-name exception does not apply here, unlike bible book names)
  - mandatory topic cross-link as the second-to-last line of the file: `~ ↳ see other verses on the same topic > [topic name](archive.html#topic-slug-verses)` (verses) or `~ ↳ see other prayers on the same topic > [topic name](archive.html#topic-slug-prayers)` (prayers) — points to the `verses`/`prayers` sub-section of that topic, not the whole section
  - on a consolidated topic's principal verse only: one `~ ↳ says the exact same thing > [title](post.html?p=bible/file.txt)` line per secondary verse — see "Same-topic consolidation" below
- `> read [another](url) one` → not part of the counter-styled engine, a plain line/link. Mandatory, always the last line of every .txt file. Forms a closed loop through ALL verses (via the ordering tracked in `all-verses-archive.html`) and, separately, a closed loop through ALL prayers (via `all-prayers-archive.html`) — see "The read another one loop" below.

## Lowercase style rule
All text, everywhere (.txt content, HTML page text, titles, headings), is lowercase — including the initial letter of sentences and titles — EXCEPT:
- words referring directly to God/religion: Lord, God, Him, His, Heaven, You/Your (when addressing God directly), and similar
- words referring to a saint: He, Him, His, and similar — same exception as God-references, anywhere on the site a saint is discussed (not only on their own page)
- proper names: book names (Isaiah, Genesis, Matthew...), people's names

Everything else, including brand names (e.g. "telegram"), sentence-initial words, and the pronoun "I" (when referring to a human, not God or a saint speaking of themself), is lowercase.

## Archive pages: adding a new book, topic, or prayer

`archive.html` is a single page — no per-book or per-topic pages. It has two anchor-based indexes at the top (`↳ author / book` and `↳ topic`, the topic index shared between verses and prayers) followed by the corresponding sections, each headed by an invisible anchor `<span id="slug"></span>Name`. Right after the `↳ topic` index line sit `↳ [all verses](all-verses-archive.html)` and `↳ [all prayers](all-prayers-archive.html)`.

Every entry (verse or prayer) is assigned exactly one topic (Claude proposes it, reusing an existing one when it fits — a topic can have only verses, only prayers, or both).

### Bible
1. Add the new .txt file under bible/.
2. **Author/book section**: if a `<span id="{book-slug}"></span>{Book}` section already exists, insert the new entry in chapter:verse ascending order among the existing `↳ {chapter}:{verse} <a>...</a>` lines under it (biblical order within the book, not insertion date). If it's a new book, create the section (positioned in canonical biblical order, Genesis → Revelation) and add `<a href="#{book-slug}">{Book}</a>` to the `↳ author / book` index line, in the same canonical position. A new book also needs a `what-is-it/{book-slug}.txt` explainer file (see "Book explainer" above) and its section header becomes `<span id="{book-slug}"></span>{Book}<span class="counter"> / <a href="post.html?p=what-is-it/{book-slug}.txt">what is it</a></span>`.
3. **Topic section**: within a topic block, the `verses` sub-section always comes before `prayers` when both exist, with no blank line between them. If a `<span id="{topic-slug}-verses"></span>– verses` sub-section already exists, insert the new entry as the first `↳ {Book} {chapter}:{verse} <a>...</a>` line under it (newest first — note the book name IS included here, since a topic section spans multiple books). If the topic exists but has no `verses` sub-section yet, create it right before any existing `prayers` sub-section. If it's a new topic, create the section (positioned alphabetically among topic sections) and add `<a href="#{topic-slug}">{topic}</a>` to the `↳ topic` index line, alphabetically.
4. Add the `~ ↳ see other verses on the same topic > [...]` and `> read [another](...) one` lines to the .txt file (see Formatting syntax above, and "The read another one loop" below).

### Prayers
1. Add the new .txt file under prayers/, named `{title-slug}.txt` — never `{topic}_{NN}.txt`. Verify the title slug doesn't collide with any existing prayer filename (uniqueness is checked across ALL prayers, not per topic).
2. **Topic section**: same logic as verses above, but for the `– prayers` sub-section (which comes after `verses` when both exist, no blank line between).
3. Insert the new entry as the first line of `all-prayers-archive.html` (newest first): `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a> | <a href="archive.html#{topic-slug}-prayers">{topic}</a>`.
4. Add the `~ ↳ see other prayers on the same topic > [...]` and `> read [another](...) one` lines to the .txt file.
5. Check `saints.html` for a genuinely relevant saint — if the new prayer's theme resonates with one, add a `↳ prayer: [title](post.html?p=prayers/{file}.txt)` line to that saint's `connections` section. Never force it.

### Saints
1. Before creating anything, check `faith/saints/{name}.md` exists in Obsidian. If it doesn't, tell the user to run the `saint-bio` skill first — don't draft the bio yourself.
2. Add the new .txt file under saints/ (see "Saint bio" file format above), pulling bio/quotes/what-resonates content from the Obsidian note and thought-capsule connections from its `↳ connections` section (reordered newest-to-oldest, date as the link).
3. Add an entry to `saints.html`, alphabetical by name: `<span id="{slug}"></span>↳ <a href="post.html?p=saints/{file}.txt">{Name}</a>`.
4. Add to `archive.html`, right after the `↳ <a href="all-prayers-archive.html">all prayers</a>` line: `↳ <a href="saints.html#{slug}">{Name}</a>`, alphabetical by name. The generic `↳ <a href="saints.html">saints</a>` link above it is only added once, when the saints section is first introduced — not per saint.
5. `index.html` only needs updating once, when the saints section is first introduced.
6. Cross-link with other saints: search all existing `saints/*.txt` files for mentions of the new saint's name and link them retroactively to the new page, `[Name](post.html?p=saints/{slug}.txt)`. Also check the new saint's own text (bio, quotes, what resonates, connections) for mentions of any existing saint and link those there too.

## The "read another one" loop

Every .txt file ends with `> read [another](post.html?p=...) one`, forming a closed loop that lets a reader keep clicking forward indefinitely, in insertion order. There are two independent loops: one through all bible verses, one through all prayers — they never cross.

- **Prayers**: the loop order is the same order as `all-prayers-archive.html` (newest first, top to bottom), which is a public, linked page.
- **Verses**: the loop order is tracked by `all-verses-archive.html`, same format and same newest-first convention. It's linked publicly from `archive.html` (`↳ all verses`).

When adding a new entry, it's inserted at the top of the relevant flat list (making it the new "newest"). Its own `read another one` link points to whichever entry was previously first (the second-newest, going forward). The entry that was previously *last* (oldest) in that same list gets its `read another one` link rewritten to point to the new entry instead — closing the loop back onto what's now newest. Every other entry's link is untouched.

## Same-topic consolidation ("says the exact same thing")

`says the exact same thing` is a stricter relation than `see other verses on the same topic`: the topic link means "related theme," this means "this other verse says the literal same thing." It applies only to verses (never prayers), and only once a topic's `verses` sub-section reaches 3 or more entries.

- When adding a new verse would bring a topic to 3+ verses (and the topic isn't already consolidated): before searching for a principal, judge whether the verses genuinely say the same identical thing (near-duplicate) or cover different angles of the same broader theme — a topic can legitimately have 3+ distinct verses with no principal at all. The threshold is only the trigger for making this judgment call, not a rule that always forces consolidation, and the judgment isn't necessarily all-or-nothing: some verses on a topic may be near-duplicates of each other while another covers a genuinely different angle and stays as its own separate entry. Present the judgment with reasoning and wait for confirmation before proceeding. Re-ask the same question each time a new verse is added to a topic that's over threshold but not consolidated — it doesn't lock in once and for all. Only once verses are confirmed as near-duplicates: search the whole Bible (not just the verses already collected) for the clearest, most explanatory verse on that theme, propose it with reasoning, and confirm with the user. That becomes the **principal** verse — it may be the new verse just added, one of the topic's existing verses, or a verse not yet in the archive (in which case it's created first, through the normal flow).
- The principal verse's file gets, after its `~ ↳ see other verses on the same topic` line and before `read another one` (blank line above and below the block, no blank line between the block's own lines), one line per other verse on that topic:
  ```
  ~ ↳ says the exact same thing > [title](post.html?p=bible/file.txt)
  ```
- In `archive.html`, that topic's `verses` sub-section keeps ONLY the principal verse's entry — the other verses' entries are removed from that sub-section. They're untouched everywhere else: still in the author/book section, still in `all-verses-archive.html`, still reachable via the "read another one" loop, still carrying their own `see other verses on the same topic` line (which leads to the now-collapsed topic section, from which the principal's own block leads to them).
- Once a topic is consolidated, later verses added to it don't repeat the whole-Bible search — they're simply appended as a new line in the principal's existing `says the exact same thing` block, and don't get their own entry in the topic sub-section.
- A topic is "already consolidated" when its `verses` sub-section has exactly one entry and that entry's file already contains a `says the exact same thing` block.

## Entry link format
- Bible, author/book section: `↳ {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Bible, topic section: `↳ {Book} {chapter}:{verse} <a href="post.html?p=bible/{file}.txt">{title}</a>`
- Prayers, topic section: `↳ <a href="post.html?p=prayers/{file}.txt">{title}</a>`
- all-prayers-archive.html / all-verses-archive.html: `↳ <a href="post.html?p={path}/{file}.txt">{title}</a> | <a href="archive.html#{slug}">{secondary}</a>` (secondary = topic for prayers, `{Book} {chapter}:{verse}` for verses)
- Archive, author/book section header: `<span id="{book-slug}"></span>{Book}<span class="counter"> / <a href="post.html?p=what-is-it/{book-slug}.txt">what is it</a></span>`

## Naming conventions
- Bible files: lowercase book name + `_` + chapter-verse, e.g. `isaiah_60-22.txt`, `romans_8-28.txt`.
- Book explainer files: `what-is-it/{book-slug}.txt`, same book-slug as the bible verse files, e.g. `what-is-it/isaiah.txt`.
- Prayer files: lowercase title, spaces→`-`, punctuation stripped, e.g. `you-are-all-i-need.txt`. A numeric suffix (`-2`, etc.) is only a rare fallback for a genuine title collision, never the default.
- Saint files: canonical English name, lowercase, spaces→`-`, e.g. `francis-of-assisi.txt`.
- Topic is always the first word of the prayer's first line (before ` | `).
- Book is always the text before the chapter:verse in the bible verse's first line.
- Slugs (topic, book) are the lowercased name with spaces and `&` replaced by `-` (e.g. `rest-stillness`).
