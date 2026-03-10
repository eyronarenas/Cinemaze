# Cinemaze

Cinemaze is a Flutter app that uses The Movie Database (TMDB) API.

## Quick setup.

1. Create a `.env` file in the project root (already present in this workspace: [.env](.env)) containing your TMDB keys and endpoints. Example keys in this repo:
   - [`TMDB_API_KEY`](.env)
   - [`TMDB_BASE_URL`](.env)
   - [`TMDB_IMG_BASE`](.env)

2.  Secrets. Ensure `.gitignore` contains `.env`.

3. Install dependencies and run:
```sh
flutter pub get
flutter run
```

## Notes

- The app reads TMDB config from the root [.env](.env) file. Keep the keys secret.
- For CI or deployment, set equivalent environment variables instead of committing `.env`.

