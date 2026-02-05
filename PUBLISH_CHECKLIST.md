# Package Publishing Checklist

Use this checklist before publishing to pub.dev.

## Pre-Publishing Checklist

### Package Configuration

- [x] Package name is unique and descriptive
- [x] Version number follows semantic versioning (1.0.0)
- [x] Description is clear and concise
- [x] Homepage/repository URLs are set
- [x] License file exists (MIT)
- [x] Dart SDK constraints are correct (^3.10.7)
- [x] Flutter constraints are correct (>=1.17.0)

### Code Quality

- [x] All code is null-safe
- [x] No compilation errors
- [x] No analysis warnings (except example print statements)
- [x] Code follows Dart style guide
- [x] All public APIs are documented with `///`
- [x] No unused imports or variables
- [x] Proper error handling

### Testing

- [x] All tests pass (`flutter test`)
- [x] Test coverage is comprehensive (100% for validators)
- [x] Edge cases are tested
- [x] Both valid and invalid inputs are tested
- [x] Error messages are tested in both languages
- [x] Integration tests exist

### Documentation

- [x] README.md is complete and informative
- [x] API documentation exists (API.md)
- [x] Quick start guide exists (QUICKSTART.md)
- [x] CHANGELOG.md is up to date
- [x] Examples are provided and working
- [x] Contributing guidelines exist
- [x] All public APIs have documentation comments

### Examples

- [x] Example directory exists
- [x] Examples are runnable
- [x] Examples demonstrate key features
- [x] Examples include comments
- [x] Simple example for quick reference

### Package Structure

- [x] Proper directory structure (lib/src/)
- [x] Main export file exists
- [x] No unnecessary files in package
- [x] .gitignore is configured
- [x] pubspec.yaml is clean

## Publishing Steps

### 1. Update Package Information

Before publishing, update these URLs in `pubspec.yaml`:

```yaml
homepage: https://github.com/yourusername/indo_form_validator
repository: https://github.com/yourusername/indo_form_validator
issue_tracker: https://github.com/yourusername/indo_form_validator/issues
```

### 2. Verify Package

```bash
# Check package quality
flutter pub publish --dry-run

# Analyze code
flutter analyze

# Run tests
flutter test

# Check formatting
dart format --output=none --set-exit-if-changed .
```

### 3. Publish to pub.dev

```bash
# Publish package
flutter pub publish
```

### 4. Post-Publishing

- [ ] Verify package appears on pub.dev
- [ ] Check package score on pub.dev
- [ ] Test installation in a new project
- [ ] Update GitHub repository with pub.dev badge
- [ ] Announce on social media/forums (optional)

## Pre-Publishing Commands

Run these commands to ensure everything is ready:

```bash
# 1. Clean and get dependencies
flutter clean
flutter pub get

# 2. Run tests
flutter test

# 3. Analyze code
flutter analyze

# 4. Format code
dart format .

# 5. Dry run publish
flutter pub publish --dry-run

# 6. Check package score
pana .
```

## Package Score Optimization

To achieve a high pub.dev score:

- [x] Follow Dart file conventions
- [x] Provide documentation
- [x] Support multiple platforms
- [x] Pass static analysis
- [x] Have good test coverage
- [x] Use null safety
- [x] Keep dependencies minimal
- [x] Provide examples

## Common Issues to Check

- [ ] No hardcoded paths
- [ ] No sensitive information
- [ ] No large files
- [ ] No unnecessary dependencies
- [ ] Proper version constraints
- [ ] Cross-platform compatibility
- [ ] No breaking changes without major version bump

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | TBD | Initial release |

## Post-1.0.0 Considerations

For future versions:

- Follow semantic versioning
- Update CHANGELOG.md
- Consider backward compatibility
- Document breaking changes
- Update examples if API changes
- Increment version appropriately:
  - Patch (1.0.x): Bug fixes
  - Minor (1.x.0): New features, backward compatible
  - Major (x.0.0): Breaking changes

## Support Channels

After publishing, set up:

- [ ] GitHub Issues for bug reports
- [ ] GitHub Discussions for questions
- [ ] Contributing guidelines
- [ ] Code of conduct (optional)
- [ ] Issue templates (optional)

## Marketing (Optional)

- [ ] Write blog post
- [ ] Share on Reddit (r/FlutterDev)
- [ ] Share on Twitter/X
- [ ] Share on LinkedIn
- [ ] Add to awesome-flutter lists
- [ ] Create demo video/GIF

## Maintenance Plan

- [ ] Monitor issues regularly
- [ ] Respond to pull requests
- [ ] Keep dependencies updated
- [ ] Fix bugs promptly
- [ ] Consider feature requests
- [ ] Update documentation as needed

## Final Checks

Before clicking publish:

1. ✅ All tests pass
2. ✅ Documentation is complete
3. ✅ Examples work
4. ✅ Version number is correct
5. ✅ CHANGELOG is updated
6. ✅ No sensitive data
7. ✅ Package name is available
8. ✅ License is appropriate

## Ready to Publish?

If all items are checked, you're ready to publish! 🚀

```bash
flutter pub publish
```

Good luck with your package! 🎉
