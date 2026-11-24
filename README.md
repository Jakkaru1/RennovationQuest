# Renovation Quest

An 8-bit style progress page for our flat renovation: percent done, last job, upcoming jobs, a floor plan map, the crew's Hall of Fame and the job history.

- `renovation-quest.html` is the source of the page (it's also published as a Claude artifact, where it can be edited with the **Edit site** button).
- `index.html` is the version for GitHub Pages. Rebuild it after changing the source:

  ```
  node build-pages.js
  ```

`og-image.png` is the picture chat apps show when the link is shared. Redraw it with:

  ```
  powershell -ExecutionPolicy Bypass -File make-preview.ps1
  ```

On GitHub Pages the page is read-only; editing and photo upload work only in the Claude artifact.
