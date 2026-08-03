# soul — Claude Code instructions

## Project structure
```
index.html            ← homepage: title "soul" + links to about.txt, kind-archives.html, topics.html (nothing else)
post.html              ← single-post viewer (loads .txt via ?p= param)
kind-archives.html     ← bible verses archive, grouped by book, canonical biblical order (Genesis → Revelation)
topics.html            ← prayers archive, grouped by topic, alphabetical order
about.txt
soulfavicon.png
bible/
  {book}_{chapter}-{verse}.txt   e.g. isaiah_60-22.txt
prayers/
  {topic}_{NN}.txt               e.g. gratitude_01.txt
```

## File formats

### Bible verse (bible/{book}_{chapter}-{verse}.txt)
First line: `Book Chapter:Verse | Title` — e.g. `Isaiah 60:22 | At the right time`
```
Book Chapter:Verse | Title
↳ [back to index](index.html)
↳ [back to kind archive](kind-archives.html)
↳ [back to topics archive](topics.html)

Content.
```

### Prayer (prayers/{topic}_{NN}.txt)
First line: `Topic | Title` — e.g. `Gratitude | You haven't abandoned me`
```
Topic | Title
↳ [back to index](index.html)
↳ [back to kind archive](kind-archives.html)
↳ [back to topics archive](topics.html)

Content.
```

Every .txt file (bible or prayer) carries all three back-links, regardless of type.

## Formatting syntax (same engine as thoughtcapsules, no day counter)
- `!!text!!` → highlight
- `\ text` → blockquote line (each line of a quote gets its own `\ `)
- `[text](url)` → link

## Insertion rules

### kind-archives.html (bible)
- Sections ordered canonically (Genesis → Revelation), one `<span id="{book-slug}"></span>` + `<mark>{Book}</mark>` heading per book that has at least one entry.
- Top anchor nav bar lists only books currently present, in canonical order: `<a href="#{book-slug}">{Book}</a>`.
- New entry: insert as the first `↳` line under its book's section (newest first).
- New book (first entry for that book): add its anchor to the nav bar in canonical position, add a new section in canonical position.

### topics.html (prayers)
- Sections ordered alphabetically by topic, one `<span id="{topic-slug}"></span>` + `<mark>{Topic}</mark>` heading per topic that has at least one entry.
- Top anchor nav bar lists only topics currently present, alphabetically: `<a href="#{topic-slug}">{Topic}</a>`.
- New entry: insert as the first `↳` line under its topic's section (newest first).
- New topic (first entry for that topic): add its anchor to the nav bar alphabetically, add a new section alphabetically.

## Entry link format
- Bible: `↳ {Chapter}:{Verse} <a href="post.html?p=bible/{file}.txt">{Title}</a>`
- Prayers: `↳ <a href="post.html?p=prayers/{file}.txt">{Title}</a>`

## Naming conventions
- Bible files: lowercase book name + `_` + chapter-verse, e.g. `isaiah_60-22.txt`, `romans_8-28.txt`.
- Prayer files: lowercase topic + `_` + two-digit sequence number (per topic), e.g. `gratitude_01.txt`, `gratitude_02.txt`, `entrusting_01.txt`.
- Topic is always the first word of the prayer's first line (before ` | `).
- Book is always the text before the chapter:verse in the bible verse's first line.
