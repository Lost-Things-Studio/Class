# Class Documentation

This folder contains the full Docusaurus documentation site.

## Local Development

```bash
cd docs
npm install
npm run start
```

## Static Build

```bash
cd docs
npm run build
```

The static site is generated in `docs/build`.

## GitHub Pages

The workflow in `.github/workflows/documentation.yml` builds this Docusaurus
site from `docs/` and deploys the generated `docs/build` artifact to GitHub
Pages on pushes to `main`.

In the repository settings, set GitHub Pages to deploy from **GitHub Actions**.
