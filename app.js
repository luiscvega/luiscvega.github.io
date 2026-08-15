const PLANE_ICON = '<svg viewBox="0 0 24 24" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M21 3 3 10.5l7.2 2.3L13 20l3-6 5-11Z"/><path d="M10.5 12.8 21 3"/></svg>';
const TRAIN_ICON = '<svg viewBox="0 0 24 24" width="17" height="17" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="3" width="14" height="13" rx="4"/><path d="M5 12h14M8 16l-2.5 4M16 16l2.5 4"/><circle cx="9" cy="9" r="0.7" fill="currentColor" stroke="none"/><circle cx="15" cy="9" r="0.7" fill="currentColor" stroke="none"/></svg>';
// Icon paths adapted from Lucide (ISC License) — navigation, utensils, camera.
const TRANSIT_ICON = '<svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><polygon points="3 11 22 2 13 21 11 13 3 11"/></svg>';
const MEAL_ICON = '<svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M3 2v7c0 1.1.9 2 2 2h4a2 2 0 0 0 2-2V2"/><path d="M7 2v20"/><path d="M21 15V2a5 5 0 0 0-5 5v6c0 1.1.9 2 2 2h3Zm0 0v7"/></svg>';
const SIGHT_ICON = '<svg viewBox="0 0 24 24" width="15" height="15" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"><path d="M14.5 4h-5L7 7H4a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2h-3l-2.5-3Z"/><circle cx="12" cy="13" r="3"/></svg>';
const MAP_ICON = '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 21s7-7.5 7-12a7 7 0 0 0-14 0c0 4.5 7 12 7 12Z"/><circle cx="12" cy="9" r="2.3"/></svg>';
const IG_ICON = '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4.2"/><circle cx="17.2" cy="6.8" r="0.6" fill="currentColor" stroke="none"/></svg>';

function pad(n) { return String(n).padStart(2, '0'); }

function todayISO() {
  const d = new Date();
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
}

function parseISO(s) { return new Date(s + 'T00:00:00'); }

function daysBetween(a, b) { return Math.round((parseISO(a) - parseISO(b)) / 86400000); }

function addDaysISO(iso, n) {
  const dt = parseISO(iso);
  dt.setDate(dt.getDate() + n);
  return `${dt.getFullYear()}-${pad(dt.getMonth() + 1)}-${pad(dt.getDate())}`;
}

function formatShort(iso) {
  return parseISO(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
}

function formatWeekday(iso) {
  return parseISO(iso).toLocaleDateString('en-US', { weekday: 'short' }).slice(0, 3).toUpperCase();
}

function clampToTrip(date) {
  if (date < TRIP.start) return TRIP.start;
  if (date > TRIP.end) return TRIP.end;
  return date;
}

function buildAllDays() {
  const days = [];
  let d = TRIP.start;
  while (d <= TRIP.end) {
    days.push(d);
    d = addDaysISO(d, 1);
  }
  return days;
}

const ALL_DAYS = buildAllDays();

function legsForDate(date) {
  return TRIP.entries.filter(e => e.type === 'leg' && (e.date === date || e.arriveDate === date));
}

function weddingEventsForDate(date) {
  const events = [];
  TRIP.entries.forEach(e => {
    if (e.wedding) e.wedding.events.forEach(ev => { if (ev.date === date) events.push(ev); });
  });
  return events;
}

function stayForDate(date) {
  const matches = TRIP.entries.filter(e => e.type === 'stay' && date >= e.start && date <= e.end);
  if (matches.length <= 1) return matches[0] || null;
  return matches.find(m => m.start === date) || matches[0];
}

function dayIndicators(date) {
  const travel = legsForDate(date).length > 0;
  const wedding = weddingEventsForDate(date).length > 0;
  return { travel, wedding };
}

/* ---------- Time parsing (for sorting the day's agenda) ---------- */

function parseTimeLabel(label) {
  if (!label) return 9999;
  const s = label.trim();
  if (/^TBD$/i.test(s)) return -1;
  if (/^Breakfast\b/i.test(s)) return 7 * 60;
  if (/^Morning\b/i.test(s)) return 8 * 60;
  if (/^Lunch\b/i.test(s)) return 12 * 60;
  if (/^Afternoon\b/i.test(s)) return 13 * 60;
  if (/^Evening\b/i.test(s)) return 18 * 60;
  if (/^Dinner\b/i.test(s)) return 19 * 60;
  const range = s.match(/(\d{1,2})\s*[-–]\s*(\d{1,2})(?::(\d{2}))?\s*(AM|PM)/i);
  if (range) {
    let h = parseInt(range[1], 10) % 12;
    if (/pm/i.test(range[4])) h += 12;
    return h * 60;
  }
  const single = s.match(/(\d{1,2})(?::(\d{2}))?\s*(AM|PM)/i);
  if (single) {
    let h = parseInt(single[1], 10) % 12;
    if (/pm/i.test(single[3])) h += 12;
    const min = single[2] ? parseInt(single[2], 10) : 0;
    return h * 60 + min;
  }
  if (/late/i.test(s)) return 23 * 60;
  return 9999;
}

/* ---------- Card templates ---------- */

function agendaRow(timeHtml, cardHtml) {
  return `<div class="agenda-row"><div class="agenda-time">${timeHtml}</div>${cardHtml}</div>`;
}

function legTimeHTML(e) {
  const overnight = e.arriveDate && e.arriveDate !== e.date;
  return `
    <span class="a-value">${e.depart}</span>
    <span class="a-rule"></span>
    <span class="a-value a-value--sub">${e.arrive || 'TBD'}</span>
    ${overnight ? `<span class="a-sub">+1</span>` : ''}`;
}

function isConnectionLeg(e) {
  const arrival = e.arriveDate || e.date;
  return TRIP.entries.some(o => o.type === 'leg' && o.from.code === e.to.code && o.date === arrival);
}

function stampLabel(e) {
  const city = e.to.city.split(' · ')[0];
  const date = formatShort(e.arriveDate || e.date);
  return `${city.toUpperCase()} · ${date.toUpperCase()}`;
}

function legCardHTML(e) {
  const icon = e.mode === 'flight' ? PLANE_ICON : TRAIN_ICON;
  const tag = e.mode === 'train' ? `<span class="tag">${e.trainName}</span>` : '';
  const stamp = !isConnectionLeg(e) ? ` data-stamp="${stampLabel(e)}"` : '';
  return `
    <div class="card leg-card"${stamp}>
      ${tag}
      <div class="route">
        <span class="code">${e.from.code}</span>
        <span class="route-icon">${icon}</span>
        <span class="code">${e.to.code}</span>
      </div>
      <p class="route-cities">${e.from.city} &rarr; ${e.to.city}</p>
      ${e.flightNumber ? `<p class="flight-meta">${e.flightNumber} · ${e.airline} · ${e.aircraft}</p>` : ''}
      ${e.baggage ? `<p class="flight-meta muted">${e.baggage}</p>` : ''}
    </div>`;
}

function weddingHeaderHTML(couple) {
  return `
    <div class="wedding-header">
      <p class="wedding-monogram">${couple}</p>
      <p class="wedding-kicker">Wedding Weekend</p>
    </div>`;
}

// Maps links are just a search query — the app doesn't need precise coordinates
// for this (unlike the map-pin feature), so any establishment with a `maps`
// query gets a link. `instagram` is only ever a verified handle, never a guess.
function googleMapsSearchURL(query) {
  // A `maps` value that's already a URL (e.g. a maps.app.goo.gl link someone
  // pasted directly) is used as-is instead of being wrapped as a search query.
  if (/^https?:\/\//i.test(query)) return query;
  return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(query)}`;
}

function instagramURL(handle) {
  return `https://www.instagram.com/${handle.replace(/^@/, '')}/`;
}

function establishmentLinksHTML(maps, instagram) {
  if (!maps) return '';
  const links = [`<a class="card-link" href="${googleMapsSearchURL(maps)}" target="_blank" rel="noopener" aria-label="Open in Google Maps">${MAP_ICON}</a>`];
  if (instagram) {
    links.push(`<a class="card-link" href="${instagramURL(instagram)}" target="_blank" rel="noopener" aria-label="Open on Instagram">${IG_ICON}</a>`);
  }
  return `<div class="card-links">${links.join('')}</div>`;
}

function weddingEventCardHTML(ev) {
  return `
    <div class="card wevent-card">
      <p class="name">${ev.name}</p>
      <p class="venue">${ev.venue}</p>
      <p class="addr">${ev.address}</p>
      <div class="dress"><strong>Dress —</strong> ${ev.dress}</div>
      <p class="note">${ev.note}</p>
      ${establishmentLinksHTML(ev.maps || ev.address, ev.instagram)}
    </div>`;
}

function planCardHTML(plan) {
  const cls = plan.kind === 'meal' ? 'plan-meal' : plan.kind === 'transit' ? 'plan-transit' : 'plan-activity';
  const icon = plan.kind === 'meal' ? MEAL_ICON : plan.kind === 'transit' ? TRANSIT_ICON : SIGHT_ICON;
  return `
    <div class="card plan-card ${cls}">
      <p class="plan-title"><span class="plan-icon">${icon}</span>${plan.title || 'Plan for today'}</p>
      ${plan.notes ? `<p class="plan-notes">${plan.notes}</p>` : ''}
      ${establishmentLinksHTML(plan.maps || plan.address, plan.instagram)}
    </div>`;
}

function emptyDayHTML() {
  return `<div class="day-open"><span class="day-open-rule"></span><span class="day-open-mark">&#9670;</span><span class="day-open-rule"></span></div>`;
}

/* ---------- PWA install + auto-update ---------- */

function setupServiceWorker() {
  if (!('serviceWorker' in navigator)) return;

  // Only a hand-off from an already-active worker to a new one is a real update.
  // The first-ever activation (no prior controller) also fires 'controllerchange',
  // and reloading then would just double-load every first visit for nothing.
  const hadController = !!navigator.serviceWorker.controller;
  window.addEventListener('load', () => navigator.serviceWorker.register('sw.js'));

  let reloadedForNewWorker = false;
  navigator.serviceWorker.addEventListener('controllerchange', () => {
    if (!hadController || reloadedForNewWorker) return;
    reloadedForNewWorker = true;
    window.location.reload();
  });
}

// Every file that affects what's rendered or how it behaves — itinerary content
// (data.js), markup (index.html), and design/behavior (styles.css, app.js) alike.
// Diffing their raw bytes against a baseline catches ANY change to any of them,
// not just ones that happen to bump a ?v=N cache-busting number — so a pure CSS
// tweak or markup edit gets picked up exactly the same as an itinerary update.
const WATCHED_FILES = ['index.html', 'styles.css', 'app.js', 'data.js'];
let contentBaseline = null;

// The ?v=N versions the RUNNING page actually loaded, read back off the DOM.
// Comparing these against the server's index.html is the only way to notice that
// *this page itself* was served stale from a cache — the content diff below can't
// see that, since it only ever compares the network against the network.
function runningAssetVersions() {
  const versions = {};
  document.querySelectorAll('script[src], link[rel="stylesheet"][href]').forEach((el) => {
    const url = el.getAttribute('src') || el.getAttribute('href');
    const match = url && url.match(/^([\w.-]+)\?v=(\d+)/);
    if (match) versions[match[1]] = match[2];
  });
  return versions;
}

function serverIsAhead(html) {
  const running = runningAssetVersions();
  for (const file in running) {
    const escaped = file.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    const match = html.match(new RegExp(escaped + '\\?v=(\\d+)'));
    if (match && match[1] !== running[file]) return true;
  }
  return false;
}

// Caches must go before reloading, or the reload can be served the very stale
// copy we're trying to get away from.
async function reloadWithFreshContent() {
  try {
    if (window.caches) {
      const names = await caches.keys();
      await Promise.all(names.map((name) => caches.delete(name)));
    }
  } catch (err) {
    // Cache API unavailable or blocked — the reload below is still worth doing.
  }
  window.location.reload();
}

async function checkForContentUpdate() {
  try {
    const texts = await Promise.all(WATCHED_FILES.map((f) => fetch(f, { cache: 'no-store' }).then((res) => res.text())));

    // Is the running page behind the server? (Catches a stale-cached page load.)
    if (serverIsAhead(texts[0])) {
      reloadWithFreshContent();
      return;
    }

    // Has anything changed since we started watching? (Catches unversioned edits.)
    const snapshot = texts.join(' ');
    if (contentBaseline === null) {
      contentBaseline = snapshot;
      return;
    }
    if (snapshot !== contentBaseline) {
      reloadWithFreshContent();
    }
  } catch (err) {
    // Offline or a transient network hiccup — just try again on the next interval.
  }
}

function setupAutoUpdate() {
  checkForContentUpdate(); // establish the baseline immediately rather than waiting for the first interval
  setInterval(checkForContentUpdate, 60000);
  document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') checkForContentUpdate();
  });
}

/* ---------- Last updated ---------- */

function relativeTimeFromNow(date) {
  const seconds = Math.round((Date.now() - date.getTime()) / 1000);
  if (seconds < 60) return 'just now';
  const minutes = Math.round(seconds / 60);
  if (minutes < 60) return `${minutes} minute${minutes === 1 ? '' : 's'} ago`;
  const hours = Math.round(minutes / 60);
  if (hours < 24) return `${hours} hour${hours === 1 ? '' : 's'} ago`;
  const days = Math.round(hours / 24);
  if (days < 7) return `${days} day${days === 1 ? '' : 's'} ago`;
  const weeks = Math.round(days / 7);
  return `${weeks} week${weeks === 1 ? '' : 's'} ago`;
}

function renderLastUpdated() {
  const el = document.getElementById('last-updated');
  if (!el || !TRIP.updated) return;
  const updated = new Date(TRIP.updated);
  const dateLabel = updated.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
  el.textContent = `Updated ${dateLabel} · ${relativeTimeFromNow(updated)}`;
}

/* ---------- Day picker ---------- */

function renderDayPicker(selected) {
  let html = '';
  let lastMonth = null;
  const today = todayISO();
  for (const date of ALL_DAYS) {
    const d = parseISO(date);
    if (d.getMonth() !== lastMonth) {
      html += `<span class="month-tick">${d.toLocaleDateString('en-US', { month: 'short' })}</span>`;
      lastMonth = d.getMonth();
    }
    const { travel, wedding } = dayIndicators(date);
    const classes = ['day-pill'];
    if (date === selected) classes.push('selected');
    if (date === today) classes.push('is-today');
    const dotClass = wedding ? 'wedding' : travel ? 'travel' : 'none';
    html += `<button class="${classes.join(' ')}" data-date="${date}" aria-pressed="${date === selected}">
        <span class="dow">${formatWeekday(date)}</span>
        <span class="num">${d.getDate()}</span>
        <span class="dot ${dotClass}"></span>
      </button>`;
  }
  document.getElementById('daypicker-scroll').innerHTML = html;
}

/* ---------- Day detail ---------- */

function dayHeadHTML(date, points) {
  const full = parseISO(date).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
  const dayNum = daysBetween(date, TRIP.start) + 1;
  const totalDays = daysBetween(TRIP.end, TRIP.start) + 1;
  const stay = stayForDate(date);
  const badge = date === todayISO() ? '<span class="today-badge">Today</span>' : '';
  return `
    <div class="day-head">
      <div class="day-head-text">
        <p class="day-head-date">${full}${badge}</p>
        <p class="day-head-sub">Day ${dayNum} of ${totalDays}${stay ? ' · ' + stay.city : ''}</p>
      </div>
      ${mapTriggerHTML(date, points)}
    </div>`;
}

const DAY_MAP_POINTS = {};

function mapTriggerHTML(date, points) {
  if (!points.length) return '';
  DAY_MAP_POINTS[date] = points;
  const label = `View ${points.length} stop${points.length === 1 ? '' : 's'} on map`;
  return `<button class="map-trigger" data-date="${date}" aria-label="${label}">${MAP_ICON}<span>${points.length}</span></button>`;
}

function dayPanelHTML(date) {
  const legs = legsForDate(date);
  const weddingEvents = weddingEventsForDate(date);
  const plans = (TRIP.days && TRIP.days[date]) || [];

  const items = [];

  legs.forEach(e => {
    items.push({ sort: parseTimeLabel(e.depart), html: agendaRow(legTimeHTML(e), legCardHTML(e)) });
  });

  if (weddingEvents.length) {
    const couple = TRIP.entries.find(e => e.wedding).wedding.couple;
    const sorted = [...weddingEvents].sort((a, b) => parseTimeLabel(a.time) - parseTimeLabel(b.time));
    let html = weddingHeaderHTML(couple);
    sorted.forEach(ev => {
      html += agendaRow(`<span class="a-value">${ev.time}</span>`, weddingEventCardHTML(ev));
    });
    items.push({ sort: parseTimeLabel(sorted[0].time), html });
  }

  plans.forEach(plan => {
    const timeHtml = plan.time ? `<span class="a-value">${plan.time}</span>` : '';
    items.push({ sort: plan.time ? parseTimeLabel(plan.time) : 9999, html: agendaRow(timeHtml, planCardHTML(plan)) });
  });

  items.sort((a, b) => a.sort - b.sort);

  const planPoints = plans
    .filter(p => p.coords)
    .slice()
    .sort((a, b) => parseTimeLabel(a.time) - parseTimeLabel(b.time))
    .map(p => ({ coords: p.coords, title: p.title, address: p.address, kind: p.kind }));

  const points = [];
  const stay = stayForDate(date);
  if (stay && stay.coords && planPoints.length) {
    points.push({ coords: stay.coords, title: 'Home base', address: stay.address, kind: 'stay' });
  }
  points.push(...planPoints);

  let inner = dayHeadHTML(date, points);
  if (items.length) {
    items.forEach(it => { inner += it.html; });
  } else {
    inner += emptyDayHTML();
  }

  return `<section class="day-panel" data-date="${date}">${inner}</section>`;
}

function renderDay(date) {
  document.getElementById('daydetail').innerHTML = dayPanelHTML(date);
}

function tripMarkerIcon(kind, number) {
  const color = kind === 'meal' ? 'var(--clay)' : kind === 'stay' ? 'var(--charcoal)' : 'var(--brass)';
  return L.divIcon({
    className: 'trip-marker',
    html: `<span class="trip-marker-num" style="background:${color}">${number}</span>`,
    iconSize: [26, 26],
    iconAnchor: [13, 13],
  });
}

function directionsURL(point) {
  const query = point.address || `${point.coords[0]},${point.coords[1]}`;
  return `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(query)}`;
}

let fullMap = null;
let mapMarkers = [];

function ensureFullMap() {
  if (fullMap) return fullMap;
  fullMap = L.map('map-full', { zoomControl: true, attributionControl: true });
  L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
    subdomains: 'abcd',
    maxZoom: 19,
    attribution: '&copy; OpenStreetMap contributors &copy; CARTO',
  }).addTo(fullMap);
  return fullMap;
}

function openDayMap(date) {
  const points = DAY_MAP_POINTS[date];
  if (!points || !points.length) return;

  document.getElementById('map-overlay-title').textContent = parseISO(date).toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
  document.getElementById('map-overlay').classList.add('open');

  const map = ensureFullMap();
  mapMarkers.forEach(m => m.remove());
  mapMarkers = points.map((point, i) => {
    const marker = L.marker(point.coords, { icon: tripMarkerIcon(point.kind, i + 1) }).addTo(map);
    marker.bindPopup(`
      <p class="map-pop-title">${point.title}</p>
      ${point.address ? `<p class="map-pop-addr">${point.address}</p>` : ''}
      <a class="map-pop-link" href="${directionsURL(point)}" target="_blank" rel="noopener">Directions &rarr;</a>`);
    return marker;
  });

  requestAnimationFrame(() => {
    map.invalidateSize();
    if (points.length === 1) {
      map.setView(points[0].coords, 15);
    } else {
      map.fitBounds(L.latLngBounds(points.map(p => p.coords)), { padding: [30, 30] });
    }
  });
}

function closeDayMap() {
  document.getElementById('map-overlay').classList.remove('open');
}

function setupMapOverlay() {
  document.getElementById('daydetail').addEventListener('click', (e) => {
    const btn = e.target.closest('.map-trigger');
    if (btn) openDayMap(btn.dataset.date);
  });
  document.getElementById('map-close').addEventListener('click', closeDayMap);
}

/* ---------- Wiring ---------- */

let selectedDate = null;

function dayIndex(date) { return ALL_DAYS.indexOf(date); }

function updateDayPickerSelection(date) {
  const picker = document.getElementById('daypicker-scroll');
  document.querySelectorAll('.day-pill').forEach(btn => {
    const active = btn.dataset.date === date;
    btn.classList.toggle('selected', active);
    btn.setAttribute('aria-pressed', String(active));
    // Scroll the strip itself rather than using scrollIntoView, which can also
    // scroll the page — unwanted now that the picker sits at the bottom.
    if (active) {
      const left = btn.offsetLeft - (picker.clientWidth - btn.offsetWidth) / 2;
      picker.scrollTo({ left: Math.max(0, left), behavior: 'smooth' });
    }
  });
}

function goToDay(date) {
  if (dayIndex(date) < 0 || date === selectedDate) return;
  selectedDate = date;
  renderDay(date);
  updateDayPickerSelection(date);
  // Start a newly chosen day at its beginning rather than wherever the previous
  // day happened to be scrolled to. #daydetail is the scrollable region now,
  // not the page itself.
  document.getElementById('daydetail').scrollTop = 0;
}

function setupDayPicker() {
  document.getElementById('daypicker').addEventListener('click', (e) => {
    const btn = e.target.closest('.day-pill');
    if (btn) goToDay(btn.dataset.date);
  });
}

function setupSwipe() {
  const el = document.getElementById('daydetail');
  let startX = 0;
  let startY = 0;
  let tracking = false;

  // No preventDefault anywhere here — vertical page scroll stays completely
  // native. We just look at the finished gesture on touchend and decide,
  // after the fact, whether it was mostly horizontal.
  el.addEventListener('touchstart', (e) => {
    if (e.touches.length !== 1) { tracking = false; return; }
    startX = e.touches[0].clientX;
    startY = e.touches[0].clientY;
    tracking = true;
  }, { passive: true });

  el.addEventListener('touchend', (e) => {
    if (!tracking) return;
    tracking = false;
    const touch = e.changedTouches[0];
    const deltaX = touch.clientX - startX;
    const deltaY = touch.clientY - startY;

    const SWIPE_THRESHOLD = 60;
    if (Math.abs(deltaX) < SWIPE_THRESHOLD || Math.abs(deltaX) < Math.abs(deltaY) * 1.5) return;

    const idx = dayIndex(selectedDate);
    const target = ALL_DAYS[idx + (deltaX < 0 ? 1 : -1)];
    if (target) goToDay(target);
  }, { passive: true });
}

function setupQuickNav() {
  document.querySelectorAll('.quicknav button[data-jump]').forEach(btn => {
    btn.addEventListener('click', () => {
      const jump = btn.dataset.jump;
      if (jump === 'today') { goToDay(clampToTrip(todayISO())); return; }
      if (jump === 'wedding') {
        const stay = TRIP.entries.find(e => e.wedding);
        if (stay) goToDay(stay.wedding.events[0].date);
        return;
      }
      const entry = TRIP.entries.find(e => e.id === jump);
      if (entry) goToDay(entry.start);
    });
  });
}

async function copyTextToClipboard(text) {
  if (navigator.clipboard && window.isSecureContext) {
    await navigator.clipboard.writeText(text);
    return;
  }
  const textarea = document.createElement('textarea');
  textarea.value = text;
  textarea.style.position = 'fixed';
  textarea.style.opacity = '0';
  document.body.appendChild(textarea);
  textarea.focus();
  textarea.select();
  const ok = document.execCommand('copy');
  document.body.removeChild(textarea);
  if (!ok) throw new Error('copy command failed');
}

function setupCopyItinerary() {
  const btn = document.getElementById('copy-itinerary');
  if (!btn) return;
  const label = btn.textContent;
  btn.addEventListener('click', async () => {
    try {
      const res = await fetch('itinerary.csv');
      if (!res.ok) throw new Error('fetch failed');
      const csv = await res.text();
      await copyTextToClipboard(csv);
      btn.textContent = 'Copied!';
    } catch (err) {
      btn.textContent = 'Copy Failed';
    }
    setTimeout(() => { btn.textContent = label; }, 1800);
  });
}

/* ---------- Layout diagnostics (opt-in via ?debug=1) ---------- */

// Runs when the URL asks for it (?debug=1) OR when toggled via 5 quick taps
// on the "Updated..." line — installed standalone PWAs have no address bar,
// so a query param can't be added once you're actually inside the app.
function setupDebugToggle() {
  const el = document.getElementById('last-updated');
  if (!el) return;
  let taps = 0;
  let timer = null;
  el.addEventListener('click', () => {
    taps++;
    clearTimeout(timer);
    timer = setTimeout(() => { taps = 0; }, 1500);
    if (taps >= 5) {
      taps = 0;
      if (localStorage.getItem('debug') === '1') localStorage.removeItem('debug');
      else localStorage.setItem('debug', '1');
      window.location.reload();
    }
  });
}

function renderLayoutDiagnostics() {
  if (!/[?&]debug=1/.test(window.location.search) && localStorage.getItem('debug') !== '1') return;

  function measureEnv(name) {
    const probe = document.createElement('div');
    probe.style.cssText = `position:fixed;left:-9999px;top:0;height:env(${name});`;
    document.body.appendChild(probe);
    const value = probe.getBoundingClientRect().height;
    probe.remove();
    return value;
  }

  const stage = document.querySelector('.stage').getBoundingClientRect();
  const picker = document.getElementById('daypicker').getBoundingClientRect();
  const vv = window.visualViewport;

  const marker = document.createElement('div');
  marker.style.cssText = 'position:fixed;left:0;right:0;bottom:0;height:2px;background:#ff00ff;z-index:9999;pointer-events:none;';
  document.body.appendChild(marker);

  const rows = [
    ['standalone', navigator.standalone],
    ['innerHeight', window.innerHeight],
    ['visualViewport.h', vv ? Math.round(vv.height) : 'n/a'],
    ['visualViewport.offsetTop', vv ? Math.round(vv.offsetTop) : 'n/a'],
    ['safe-bottom env()', measureEnv('safe-area-inset-bottom')],
    ['stage bottom', Math.round(stage.bottom)],
    ['picker top/bottom', `${Math.round(picker.top)}/${Math.round(picker.bottom)}`],
    ['gap: innerHeight - picker.bottom', Math.round(window.innerHeight - picker.bottom)],
    ['gap: stage.bottom - picker.bottom', Math.round(stage.bottom - picker.bottom)],
  ];

  const box = document.createElement('div');
  box.style.cssText =
    'position:fixed;left:8px;bottom:8px;z-index:9999;background:rgba(0,0,0,0.9);color:#0f0;' +
    'font:600 11px/1.5 monospace;padding:8px 10px;border-radius:6px;pointer-events:none;' +
    'display:grid;grid-template-columns:auto auto;gap:0 10px;';
  box.innerHTML = rows.map(([k, v]) => `<span style="color:#888">${k}</span><span>${v}</span>`).join('');
  document.body.appendChild(box);
}

function init() {
  const initial = clampToTrip(todayISO());
  setupServiceWorker();
  setupAutoUpdate();
  renderLastUpdated();
  setInterval(renderLastUpdated, 60000);
  setupDebugToggle();
  renderDayPicker(initial);
  setupDayPicker();
  setupSwipe();
  setupQuickNav();
  setupCopyItinerary();
  setupMapOverlay();
  selectedDate = initial;
  renderDay(initial);
  updateDayPickerSelection(initial);
  renderLayoutDiagnostics();
}

init();
