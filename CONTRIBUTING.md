# Contributing to Full Dev Setup Ubuntu

Thank you for your interest in contributing to Full Dev Setup Ubuntu! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

If you encounter any problems or have suggestions for improvements:

1. Check if the issue already exists in the [Issues](https://github.com/RohanMagar7/Full-Dev-Setup-Ubuntu-/issues) section
2. If not, create a new issue with:
   - A clear and descriptive title
   - Detailed description of the problem or suggestion
   - Steps to reproduce (if applicable)
   - Your Ubuntu version
   - Expected vs actual behavior
   - Any relevant logs or error messages

### Submitting Changes

1. **Fork the Repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/Full-Dev-Setup-Ubuntu-.git
   cd Full-Dev-Setup-Ubuntu-
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
   
   Use descriptive branch names:
   - `feature/` for new features
   - `fix/` for bug fixes
   - `docs/` for documentation changes
   - `refactor/` for code refactoring

3. **Make Your Changes**
   - Follow the existing code style
   - Test your changes thoroughly
   - Update documentation if needed
   - Ensure scripts have proper error handling
   - Add comments for complex logic

4. **Test Your Changes**
   - Test on a clean Ubuntu installation if possible
   - Verify that existing functionality still works
   - Test both fresh installations and updates

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Brief description of your changes"
   ```
   
   Write clear commit messages:
   - Use present tense ("Add feature" not "Added feature")
   - Keep the first line under 50 characters
   - Add detailed description if needed

6. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Provide a clear description of your changes
   - Reference any related issues

## Coding Guidelines

### Shell Scripts

- Use `#!/bin/bash` as shebang
- Set `set -e` to exit on errors
- Use meaningful variable names
- Add comments for complex sections
- Use functions to organize code
- Provide user feedback (log messages)
- Handle errors gracefully

### Documentation

- Update README.md for significant changes
- Keep documentation clear and concise
- Include examples where helpful
- Update version numbers if applicable

## Types of Contributions

We welcome various types of contributions:

### New Features

- Additional programming languages or tools
- New modular installation scripts
- Enhanced configuration templates
- Automation improvements

### Bug Fixes

- Fix installation issues
- Correct script errors
- Address compatibility problems

### Documentation

- Improve existing documentation
- Add new guides or tutorials
- Fix typos and clarify instructions
- Add troubleshooting solutions

### Testing

- Test on different Ubuntu versions
- Report compatibility issues
- Verify installation procedures

## Code Review Process

1. Maintainers will review your pull request
2. You may be asked to make changes
3. Once approved, your PR will be merged
4. Your contribution will be acknowledged in the release notes

## Community Guidelines

- Be respectful and constructive
- Help others when possible
- Follow the [Code of Conduct](CODE_OF_CONDUCT.md)
- Stay on topic in discussions

## Questions?

If you have questions about contributing:

- Open an issue for discussion
- Check existing issues and pull requests
- Review the documentation

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Full Dev Setup Ubuntu! 🎉
