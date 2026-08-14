---
name: update-itinerary
description: Use this skill whenever the user describes a change to the Manila → Europe trip itinerary on this site — a new or moved activity/meal/reservation, a changed flight or train, a different hotel/stay, an updated wedding event detail, or a date/time correction. Trigger on plain-language requests like "move Sept 3 dinner to 8pm", "add a stop at the Musée Rodin on Sept 6 afternoon", "my return flight changed to QR930", "the ceremony venue address changed", or "delete the Angelina stop". Also trigger for "publish this" / "push the itinerary update" once a change has been discussed. Do NOT trigger for unrelated site code changes (styling, layout, new features) — this skill is only for itinerary content edits that end in a commit + push to main.
---

# Update Itinerary

Turn a plain-language itinerary change into an edit of this repo's trip data, then publish it live. The user drives this from their phone — they expect the whole loop (edit → commit → push) to happen in one turn, with no approval gate, because they already decided (standing instruction) that itinerary edits push straight to `main`. GitHub Pages serves this repo directly from `main`, so a push is the same thing as publishing.

## Where the data lives

Two files hold the itinerary; which one(s) you touch depends on what kind of thing changed.

**`data.js`** — the source of truth the site actually renders. A single `TRIP` object:
- `TRIP.start` / `TRIP.end` — the visible date range. Read the comment above them before touching either; the range is currently trimmed on purpose (see "Date-range changes" below).
- `TRIP.entries[]` — flights/trains (`type: 'leg'`), lodging (`type: 'stay'`, one of which carries a nested `wedding: { couple, events: [...] }`).
- `TRIP.days{}` — keyed by ISO date (`'2026-09-03'`), each an array of plan items: `{ time, kind, title, notes, address?, coords? }`. `kind` is `'activity'`, `'meal'`, or `'transit'`.

**`itinerary.csv`** — a flat export of *only* the `TRIP.days` plan items (legs/stays/wedding events aren't in it — it has no room for them). Columns: `Start Date, Start Time, End Time, Location, Area, Category, Activity, Notes`. Dates are `M/D/YYYY` (not ISO), times are `#:## AM/PM`, and `Category` is more granular than `kind` — map it:

| data.js `kind` | itinerary.csv `Category` |
|---|---|
| `transit` | `Travel` |
| `meal` | `Dining`, `Coffee`, `Drinks`, or `Dessert` — pick the specific one |
| `activity` | `Excursion`, `Shopping`, or `Rest & Prep` — pick the specific one |

The site's "Copy Itinerary" button fetches this CSV verbatim and copies it to the clipboard — it's for pasting into calendars/notes apps, so keep it human-readable and in chronological row order.

## Deciding what to touch

- **Day-plan item changed/added/removed** (an activity, meal, coffee stop, shopping block, transit hop) → edit **both** `TRIP.days[date]` in `data.js` and the matching row(s) in `itinerary.csv`. Match `End Time` in the CSV to the *next* item's start time (or a sensible duration if it's the last item of a block), following how neighboring rows already do it.
- **Flight, train, stay, or wedding-event change** → edit **only** `TRIP.entries` in `data.js`. `itinerary.csv` has no model for these, so leave it alone.
- **Something that's genuinely ambiguous** (which of two same-day dinners they mean, an address that could refer to two different venues) → ask, once, with a specific question. Don't ask about things you can just decide (exact wording of a `notes` field, which CSV `Category` a coffee stop gets).

### Map coordinates

`coords` is what puts a pin on the day's map (see `mapTriggerHTML`/`dayPanelHTML` in `app.js`) — an `address` alone does **not** produce a pin and isn't shown anywhere else in the UI, so an address with no coords is currently dead data. When a new activity has a real, well-known, publicly-locatable place (a museum, landmark, named restaurant), look up its coordinates yourself (WebSearch/WebFetch) rather than asking the user for lat/lng they won't have handy — but don't invent coordinates from memory. If the place is private, ambiguous, or the lookup is inconclusive, add the item without `coords`/`address` and tell the user in your summary that it won't have a map pin.

### Date-range changes

`TRIP.start`/`TRIP.end` are currently trimmed to Sep 2–9 even though `TRIP.entries` covers the full Aug 28–Sep 16 trip (the comment in `data.js` and a matching HTML comment in `index.html` explain why: Zurich/Gordes/Rome are hidden while the range is trimmed). If a request touches a date outside the current visible range, don't silently expand or leave the range untouched — ask the user whether to widen it first.

## Procedure

1. Read the relevant slice of `data.js` and `itinerary.csv` (and check `app.js`'s `parseTimeLabel`/sort logic if a time format is unusual — items render in time-sorted order regardless of array order, so you don't need to physically reorder `TRIP.days`, but do keep new CSV rows in chronological position since the CSV is copied verbatim).
2. Make the edit(s) with `Edit`, following the exact conventions already in each file (quote style, date/time formatting, trailing commas, comment style).
3. If `data.js` changed, bump its cache-busting version in `index.html` — find `<script src="data.js?v=N">` and increment `N`. Leave `app.js`'s `?v=` alone unless you also touched `app.js` (which this skill normally shouldn't).
4. Show the user a short before → after summary of the substance of the change (not a raw diff dump) — e.g. "Moved Sept 3 dinner from La Bourse et La Vie 7:00 PM to 8:00 PM; updated the CSV row to match."
5. Commit with a message describing the itinerary change itself (e.g. `Move Sept 3 dinner to 8pm`), not the mechanics of the edit. Keep the commit scoped to the itinerary content — don't refactor or touch unrelated code while you're in there.
6. Push straight to `main` (`git push origin HEAD:main` if not already on `main`, otherwise `git push`). This repo publishes with no build step or CI gate, so a successful push is the publish.
7. Tell the user it's pushed and will be live on the site within a minute or two (typical GitHub Pages propagation).

Don't ask "should I proceed?" before step 6 for a routine, unambiguous edit — the user already decided direct-to-main is how this works. Only pause for a real ambiguity (step above), never as a generic confirmation gate.
