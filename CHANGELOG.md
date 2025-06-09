# Changelog

All notable changes to this project will be documented in this file.

## [v0.2k] – 2025-06-09
### Added
- Support for **single shared affiliation**: when only one affiliation is used, no affiliation superscript is printed, but any per-author email symbols still appear.  
- Refactored `\printauthors` / `\printaffils` logic to handle both multi- and single-affiliation cases seamlessly.
- Ensured email footnotes always use symbol style (`*`, `†`, etc.), even with one affiliation.

### Fixed
- Email‐symbol superscripts disappearing when there was only one affiliation.
- Minor syntax tweaks in Section 8 of the class to avoid “undefined command” errors.

## [v0.2j] – 2025-06-08
### Added
- Per-author `\email{…}` support: automatically assigns distinct symbol footnotes for corresponding authors.  
- Automatic, deduplicated numbering of affiliations; multiple authors sharing an affiliation use the same number.  
- Custom `\maketitle` that prints title, authors (with affiliation ⁿ and email symbols), affiliation list, and date.

### Improvements
- Switched caption font to `\footnotesize` upright and added a colored rule above captions.  
- Boxed, compact abstract environment in soft background.  
- Decorative drop-cap command `\firstletter{…}`.

## [v0.2i] – 2025-06-07
### Initial public release (v0.2)
- Single-column, wide-margin layout for physics papers.  
- Libertinus text + NewTX math + Mathalfa for extended alphabets.  
- Sans-serif bold headings with subtle colored underline.  
- Core support for graphics, microtype, math, and numeric citations.

---

*For details on usage and customization, see the [README.md](README.md).*
