#!/bin/bash
# Mirror-integrity audit between soul (English) and soul-it (Italian).
# Run this before ending any session that touched soul or soul-it, and
# always before a commit/push that includes either repo — see CLAUDE.md
# "Mirroring enforcement" section for when this is mandatory.
#
# Exits non-zero if any problem is found.

set -u
SOUL="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOULIT="$(cd "$SOUL/../soul-it" 2>/dev/null && pwd)"
FAIL=0

if [ -z "$SOULIT" ] || [ ! -d "$SOULIT" ]; then
  echo "ERROR: could not find soul-it next to soul (expected ../soul-it)"
  exit 1
fi

echo "== 1/4: soul -> soul-it language-selector round trip =="
for dir in prayers commonplace saints bible what-is-it; do
  for f in "$SOUL/$dir"/*.txt; do
    [ -f "$f" ] || continue
    line=$(grep -oE 'ivana-rep\.github\.io/soul-it/post\.html\?p=[^)]+\.txt' "$f" | head -1)
    if [ -n "$line" ]; then
      target=$(echo "$line" | sed 's#.*p=##')
      if [ ! -f "$SOULIT/$target" ]; then
        echo "BROKEN (soul->it): $dir/$(basename "$f") claims -> $target (missing in soul-it)"
        FAIL=1
      fi
    fi
  done
done

echo "== 2/4: soul-it -> soul language-selector round trip =="
for dir in prayers commonplace saints bible what-is-it; do
  for f in "$SOULIT/$dir"/*.txt; do
    [ -f "$f" ] || continue
    line=$(grep -oE 'ivana-rep\.github\.io/soul/post\.html\?p=[^)]+\.txt' "$f" | head -1)
    if [ -n "$line" ]; then
      target=$(echo "$line" | sed 's#.*p=##')
      if [ ! -f "$SOUL/$target" ]; then
        echo "BROKEN (it->soul): $dir/$(basename "$f") claims -> $target (missing in soul)"
        FAIL=1
      fi
    fi
  done
done

echo "== 3/4: soul content files with no mirror at all (missing language-selector line) =="
for dir in prayers commonplace saints bible what-is-it; do
  for f in "$SOUL/$dir"/*.txt; do
    [ -f "$f" ] || continue
    grep -qE 'ivana-rep\.github\.io/soul-it/post\.html\?p=' "$f" || {
      echo "NO MIRROR (soul): $dir/$(basename "$f") has no en->it language-selector line at all"
      FAIL=1
    }
  done
done
for dir in prayers commonplace saints bible what-is-it; do
  for f in "$SOULIT/$dir"/*.txt; do
    [ -f "$f" ] || continue
    grep -qE 'ivana-rep\.github\.io/soul/post\.html\?p=' "$f" || {
      echo "NO MIRROR (soul-it): $dir/$(basename "$f") has no it->en language-selector line at all"
      FAIL=1
    }
  done
done

echo "== 4/4: internal dangling post.html?p= links within each repo =="
# Only matches post.html?p=... when it's a genuine same-repo reference —
# i.e. immediately preceded by href=" or ]( — never a fragment inside a
# full cross-repo/cross-site URL like https://.../soul-it/post.html?p=...
# or https://.../thoughtcapsules/post.html?p=..., which point elsewhere.
for repo in "$SOUL" "$SOULIT"; do
  name=$(basename "$repo")
  while IFS= read -r ref; do
    [ -f "$repo/$ref" ] || { echo "DANGLING ($name): $ref referenced but missing"; FAIL=1; }
  done < <(grep -rhoE '(href="|\]\()post\.html\?p=[a-zA-Z0-9_/.-]+\.txt' "$repo" --include="*.html" --include="*.txt" 2>/dev/null | sed -E 's/^(href="|\]\()post\.html\?p=//' | sort -u)
done

echo
if [ "$FAIL" -eq 0 ]; then
  echo "OK: no mirroring or dangling-link problems found."
else
  echo "FAIL: problems found above — fix before committing."
fi
exit $FAIL
