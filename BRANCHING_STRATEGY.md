# Branching Strategy

This document outlines the branching strategy for the 272-jenkins project, a Dynamics 365 Business Central AL project with Jenkins CI/CD integration.

## Branch Structure

### Main Branches

#### `main` (or `master`)
- **Purpose**: Production-ready code
- **Protection**: Protected branch with required reviews
- **Deployment**: Automatically deploys to production environment
- **Merges From**: `release/*` and `hotfix/*` branches only
- **Direct Commits**: Not allowed

#### `develop`
- **Purpose**: Integration branch for features
- **Protection**: Protected branch with required reviews
- **Deployment**: Automatically deploys to development environment
- **Merges From**: `feature/*` branches
- **Direct Commits**: Not allowed

### Supporting Branches

#### Feature Branches (`feature/*`)
- **Purpose**: Development of new features or enhancements
- **Naming Convention**: `feature/<issue-number>-<short-description>`
  - Example: `feature/123-add-customer-portal`
- **Base Branch**: `develop`
- **Merge Target**: `develop`
- **Lifetime**: Temporary, deleted after merge
- **Jenkins**: Runs build and unit tests on each push

#### Release Branches (`release/*`)
- **Purpose**: Preparation for production release
- **Naming Convention**: `release/<version>`
  - Example: `release/1.2.0`
- **Base Branch**: `develop`
- **Merge Target**: `main` and `develop`
- **Lifetime**: Temporary, deleted after release
- **Jenkins**: Runs full test suite and deployment validation

#### Hotfix Branches (`hotfix/*`)
- **Purpose**: Critical bug fixes for production
- **Naming Convention**: `hotfix/<issue-number>-<short-description>`
  - Example: `hotfix/456-fix-payment-calculation`
- **Base Branch**: `main`
- **Merge Target**: `main` and `develop`
- **Lifetime**: Temporary, deleted after merge
- **Jenkins**: Runs full test suite and expedited deployment

#### Bugfix Branches (`bugfix/*`)
- **Purpose**: Non-critical bug fixes
- **Naming Convention**: `bugfix/<issue-number>-<short-description>`
  - Example: `bugfix/789-correct-label-text`
- **Base Branch**: `develop`
- **Merge Target**: `develop`
- **Lifetime**: Temporary, deleted after merge
- **Jenkins**: Runs build and unit tests

## Workflow

### Feature Development

1. Create feature branch from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/123-new-feature
   ```

2. Develop and commit changes:
   ```bash
   git add .
   git commit -m "Implement new feature"
   git push origin feature/123-new-feature
   ```

3. Create Pull Request to `develop`
4. Code review and Jenkins validation
5. Merge to `develop` after approval
6. Delete feature branch

### Release Process

1. Create release branch from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b release/1.2.0
   ```

2. Perform final testing and bug fixes
3. Update version numbers and changelog
4. Create Pull Request to `main`
5. After approval, merge to `main`:
   ```bash
   git checkout main
   git merge --no-ff release/1.2.0
   git tag -a v1.2.0 -m "Release version 1.2.0"
   git push origin main --tags
   ```

6. Merge back to `develop`:
   ```bash
   git checkout develop
   git merge --no-ff release/1.2.0
   git push origin develop
   ```

7. Delete release branch

### Hotfix Process

1. Create hotfix branch from `main`:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b hotfix/456-critical-fix
   ```

2. Fix the issue and commit:
   ```bash
   git add .
   git commit -m "Fix critical issue"
   ```

3. Create Pull Request to `main`
4. After urgent review and Jenkins validation, merge to `main`:
   ```bash
   git checkout main
   git merge --no-ff hotfix/456-critical-fix
   git tag -a v1.2.1 -m "Hotfix version 1.2.1"
   git push origin main --tags
   ```

5. Merge back to `develop`:
   ```bash
   git checkout develop
   git merge --no-ff hotfix/456-critical-fix
   git push origin develop
   ```

6. Delete hotfix branch

## Pull Request Guidelines

### Requirements
- All PRs must pass Jenkins build and tests
- At least one code review approval required
- No merge conflicts with target branch
- Follow AL coding standards and conventions
- Include tests for new functionality

### PR Template
When creating a PR, include:
- **Description**: Clear explanation of changes
- **Issue Reference**: Link to related issue(s)
- **Testing**: Description of testing performed
- **Screenshots**: For UI changes (if applicable)
- **Breaking Changes**: Any breaking changes noted

## Jenkins CI/CD Integration

### Automated Checks
- **On Feature/Bugfix Push**: 
  - AL code compilation
  - Unit tests
  - Code quality checks
  
- **On Release/Hotfix Push**:
  - Full test suite
  - Integration tests
  - Security scans
  - Deployment validation

- **On Merge to Develop**:
  - Deploy to development environment
  - Run smoke tests

- **On Merge to Main**:
  - Deploy to production environment
  - Tag release
  - Generate release notes

## Version Control Best Practices

### Commit Messages
- Use clear, descriptive commit messages
- Reference issue numbers when applicable
- Format: `<type>: <description> (#issue-number)`
- Types: feat, fix, docs, style, refactor, test, chore

### Branch Hygiene
- Keep branches up to date with base branch
- Delete branches after merge
- Avoid long-lived feature branches
- Rebase feature branches before merging (optional)

### Merge Strategy
- Use `--no-ff` (no fast-forward) for main merges to preserve history
- Squash commits for feature branches (optional)
- Keep commit history clean and readable

## AL-Specific Considerations

### AL Project Structure
- Keep object IDs consistent across branches
- Coordinate object ID ranges with team
- Test AL package dependencies before merging

### Business Central Environments
- **Development**: Synced with `develop` branch
- **Testing/UAT**: Synced with `release/*` branches
- **Production**: Synced with `main` branch

### Extension Management
- Version extensions according to branch strategy
- Test extension upgrades before releasing
- Maintain backward compatibility when possible

## Troubleshooting

### Merge Conflicts
1. Update your branch with latest from base branch
2. Resolve conflicts locally
3. Test thoroughly after resolution
4. Push resolved changes

### Failed Jenkins Builds
1. Review Jenkins build logs
2. Fix issues locally
3. Run tests locally before pushing
4. Push fix and wait for Jenkins validation

## References

- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [AL Development Guidelines](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview)
- [Jenkins Best Practices](https://www.jenkins.io/doc/book/pipeline/pipeline-best-practices/)
