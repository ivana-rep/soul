# soul — file formats

Full per-type templates and rules for every `.txt` content type in the `soul` project. Referenced from `soul/CLAUDE.md`'s "File formats" pointer — read this file when doing ad-hoc/manual content edits outside the four content-creation skills (which already embed the exact write template they need). Everything below stays governed by `soul/CLAUDE.md`'s Approval model, lowercase style rule, and mirroring rules — this file only covers structure/syntax.

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

~ ↳ see saint connection >
~ [Name](post.html?p=saints/{slug}.txt)

~ ↳ related verses >
~ [Book Chapter:Verse](post.html?p=bible/file.txt) | title

> read [another](post.html?p=bible/next-file.txt) one
```
The verse text is the literal NLT translation — never paraphrased or shortened — but still gets the lowercase style rule applied (no exception for scripture). In longer verses, break the quote onto separate lines at natural clause/sentence boundaries rather than one continuous line.

Mark every verse number with `[N]` — `post.html` renders this as a small gray `.counter`-styled span. The first marker goes at the start of the text; if a quote spans multiple verses, later markers go wherever that verse begins in the NLT source, not necessarily at the start of a line (e.g. `[22] the smallest family...`).

The source line is optional, and — unlike every other cross-reference line below — sits right after the verse text, before the reflection block. The `---` + reflection + `---` block is optional: if there's no reflection, neither separator appears, no extra section. Every line from immediately after the closing `---` (or immediately after the verse text, if there's no reflection) onward is counter-styled (`~` prefix), with one exception: `read another one` always stays a plain, prominent link, never counter-styled — everything else is counter-styled. The topic cross-link line is mandatory. The saint-connection line is optional — only when a saint's page genuinely links to this verse (see "Saints" workflow below) — and mirrors that link back; one line per saint if more than one connects. The `related verses` block is optional: a hand-picked, selective set of specific other verses that genuinely say something closely related — never the whole topic (that's what the topic cross-link is for) — one `~ [Ref](url) | title` line per verse, reference linked (never the title), no blank line between the header and the list or between list lines. The `read another one` line is mandatory and is always the file's last line. Whenever a reflection clearly mentions or quotes another verse already on the site, link it inline right where it's mentioned — and also add it to the `related verses` block if it isn't there already. The inline link never substitutes for the cross-reference entry; both go together.

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

~ ↳ see saint connection >
~ [Name](post.html?p=saints/{slug}.txt)

~ ↳ related prayers >
~ [title](post.html?p=prayers/file.txt)

> read [another](post.html?p=prayers/next-file.txt) one
```
Same optionality and structure as bible verses above: source (if present) sits right after the prayer text, before the reflection; the reflection, if present, is wrapped in an opening and closing `---`; everything from there onward is counter-styled except `read another one`, which stays a plain link and is always the file's last line. The topic cross-link (`see other prayers on the same topic`, unchanged) is mandatory. The saint-connection line is optional, same rule as bible verses. The `related prayers` block is optional and selective, same rule as `related verses` — one `~ [title](url)` line per related prayer (no reference/chapter needed here, just the title). Same inline-linking rule as bible verses above: a reflection that clearly mentions or quotes another verse/prayer already on the site gets an inline link at the point of mention, plus an entry in the `related verses`/`related prayers` block if missing.

### Commonplace (commonplace/{title-slug}.txt)
For quotes/prompts that don't fit bible verse, prayer, or saint bio: no scripture reference, not addressed to God, not a known saint's own words — e.g. a quote from a book, an unattributed devotional-app prompt. A commonplace-book style catch-all, separate from the topic system entirely (no topic assignment, no section in `archive.html`).

First line: `title | author` — title lowercase (same rule as prayer titles), author omitted entirely (no ` | ` at all) when the quote is unattributed. Unlike the bible/prayer `source:` line, the author name here DOES follow the proper-name exception (capitalized, like a person's name) since it's a byline, not a source citation.
```
title | author
↳ [back to index](index.html)
↳ [back to archive](archive.html)

\ quote text (blockquote syntax, one line per line of the quote; may use !!highlight!!, same as bible verses)

---

~ ↳ source: [name](url)

~ ↳ see saint connection >
~ [Name](post.html?p=saints/{slug}.txt)

~ ↳ related verses >
~ [Book Chapter:Verse](post.html?p=bible/file.txt) | title

~ ↳ related prayers >
~ [title](post.html?p=prayers/file.txt)

> see [another](post.html?p=commonplace/next-file.txt) one
```
No reflection section (the quote is the content, never a separate reflection block) — so there's only ever a single `---`, dividing the quote from the counter-styled block below it. Everything from immediately after that `---` onward is counter-styled, with the sole exception of `see [another](...) one` (the commonplace equivalent of `read another one` — different wording, same plain-link rule, always the file's last line). The optional `source` line sits first in the counter block (unlike bible/prayer, it comes after the `---`, not before, since there's no reflection to precede). Saint-connection, related-verses, and related-prayers blocks are all optional and selective, same "never force it" rule as elsewhere, same bidirectional-linking convention.

### Book explainer (what-is-it/{book-slug}.txt)
First line: `Book | what is it` — book capitalized (proper name), `what is it` is always fixed, lowercase, never changes.
```
Book | what is it
↳ [back to index](index.html)
↳ [back to archive](archive.html)

A few lines explaining what the book is: author/attribution, genre, Old/New Testament, main themes. Factual, concise — no reflection section, no source line, no topic cross-link, no `read another one` loop (this is a third content type, separate from verses and prayers).
```
One file per book that has at least one verse cited in `archive.html`. Not part of either "read another one" loop.

When naming the author/character, give the reader enough context to place who that is — never a bare name with no identification, but also never a full bio. A short appositive/epithet at first mention is the right amount (e.g. "the apostle Paul", "Solomon, David's son and Israel's king renowned for his wisdom", "Moses — a fugitive shepherd called back to confront Pharaoh and lead his people to freedom"). Skip the epithet only if the book's own description already makes clear who the person is (e.g. Exodus already narrates Moses's calling). Applies whether writing a new book explainer or revising an existing one.

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
↳ verse: [Book Chapter:Verse](post.html?p=bible/file.txt) — title
↳ prayer: [title](post.html?p=prayers/file.txt)
↳ commonplace: [title](post.html?p=commonplace/file.txt)
```
Every section is headed by `↳ section name` (lowercase), with one blank line between sections and no blank line inside a section. The `bio` timeline is chronological (birth → death/canonization), not newest-first — the only place on the site where entries aren't newest-first. Quotes use the `\ ` blockquote syntax (one line per line of the quote) followed by a `~ — attribution` counter-styled line (no `↳`, since it isn't a cross-reference). `what resonates with me` uses literal `* ` bullets (same convention as thoughtcapsules), one per line, no blank lines between. `connections` links relevant verses/prayers/commonplace entries already in the archive — chosen for genuine resonance, never forced, may be omitted entirely if nothing genuinely fits. Every verse/prayer/commonplace connection is bidirectional: the linked file gets a matching `~ [Name](post.html?p=saints/{slug}.txt)` entry in its own saint-connection block (see the bible/prayer/commonplace Formatting syntax above) — never link only from the saint's side. Thought-capsule connections are no longer added anywhere on the site (saint bios or verse/prayer files) — this practice was discontinued.

Saint cross-linking: anywhere in a saint's file — bio, quotes, what resonates with me, connections — another saint's name appears, it's linked to that saint's page if one already exists: `[Name](post.html?p=saints/{slug}.txt)`. This runs both directions when a new saint is added — see "Saints" workflow step 7 below.

Source content is generated by the `soul-saint` skill itself (web research for feast day/timeline/verified quotes, plus the user's own "what resonates with me" reflection) — never Obsidian. The skill drafts the full file at `soul/.saint-drafts/{slug}.txt` and shows it for approval (per the Approval model above — a saint bio is substantially Claude-generated) before promoting it into `saints/{slug}.txt`.

This is a separate content type, like the book explainer: no reflection-vs-verse distinction, no source line, no topic cross-link, no "read another one" loop.

Every .txt file (bible, prayer, commonplace, book explainer, or saint bio) carries both back-links (index, archive), regardless of type. Links inside .txt files are resolved relative to post.html (which lives at the repo root), so never prefix them with `../` even though the .txt file itself lives in bible/, prayers/, or commonplace/.
