# myWeight

Single‑page web app for logging daily weight with charts and history.

## Run
Open `index.html` in a browser.

## Notes
- Data is stored locally in the browser (localStorage).
- To enable Supabase sync, set `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `index.html` and run `supabase.sql` in your Supabase SQL editor.
- Supabase auth supports email/password, magic link, and password reset. All settings (unit, goal, profile) are stored in `user_settings`.
