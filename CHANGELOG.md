# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).


## [1.3] - 2024-01-30
### Changed
- Changed counter names
  - `reviewer@counter` to `reviewer`
  - `reviewcomment@counter` to `revcomment`

### Added
- Add `\autorefname` for `reviewer` and `revcomment`
- Add default PDF property values for title, author, and keywords when using
  the hyperref package

## [1.2.2] - 2023-05-24
### Changed
- Change glue space after response blocks

## [1.2.1] - 2022-10-18
### Added
- Add widow and orphan line penalty

## [1.2] - 2021-11-10
### Added
- The `revcomment` environment now accepts arguments, which are directly passed
  to the underlying `tcolorbox`.
