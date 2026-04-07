# Code Review Checklist

## General Principles

### ✅ Must Haves (Blockers)
- [ ] **Functionality** - Code works as intended and meets acceptance criteria
- [ ] **No Breaking Changes** - Doesn't break existing functionality
- [ ] **Tests Updated** - Tests added/updated for new/changed functionality
- [ ] **No Security Issues** - No vulnerabilities or unsafe practices
- [ ] **No Memory Leaks** - Especially critical for C++/Rust code

### 🚨 Should Haves (Important)
- [ ] **Code Style** - Follows project coding standards
- [ ] **Error Handling** - All error cases properly handled
- [ ] **Edge Cases** - Boundary conditions tested
- [ ] **Performance** - No obvious performance regressions
- [ ] **Readability** - Code is easy to understand and maintain

### 📏 Could Haves (Nice to Have)
- [ ] **Documentation** - Functions/classes documented
- [ ] **Logging** - Appropriate log statements added
- [ ] **Comments** - Complex logic explained
- [ ] **Constants** - Magic numbers replaced with named constants
- [ ] **Dependencies** - No unnecessary dependencies added

## Language-Specific Checks

### C++ Code Review

#### Memory Management
- [ ] No raw `new`/`delete` (use smart pointers)
- [ ] No memory leaks (checked with Valgrind/AddressSanitizer)
- [ ] RAII patterns used consistently
- [ ] No dangling pointers
- [ ] Proper ownership semantics

#### Performance
- [ ] No unnecessary copies (use const references)
- [ ] Move semantics used where appropriate
- [ ] No excessive heap allocations
- [ ] Cache-friendly data access patterns
- [ ] Algorithmic complexity appropriate

#### Safety
- [ ] No buffer overflows/underflows
- [ ] Bounds checking on containers
- [ ] No unchecked casts
- [ ] Thread safety where needed
- [ ] No data races

#### Modern C++ Practices
- [ ] Uses C++17/20 features appropriately
- [ ] `override`/`final` keywords used
- [ ] `noexcept` specifiers used
- [ ] `constexpr` where possible
- [ ] Range-based for loops instead of index loops

### Rust Code Review

#### Memory Safety
- [ ] No `unsafe` blocks unless absolutely necessary
- [ ] Proper borrowing rules followed
- [ ] No data races (Send/Sync used correctly)
- [ ] Lifetimes properly annotated
- [ ] No unnecessary `clone()` calls

#### Error Handling
- [ ] All errors handled with `Result<T, E>`
- [ ] `?` operator used appropriately
- [ ] No `unwrap()` or `expect()` in production code
- [ ] Proper error messages

#### Concurrency
- [ ] Thread safety guaranteed by ownership system
- [ ] `Arc<Mutex<T>>` used appropriately
- [ ] No shared mutable state
- [ ] `Send`/`Sync` traits implemented correctly

#### Performance
- [ ] No unnecessary allocations
- [ ] Iterator chains optimized
- [ ] `match` instead of `if let` for enums
- [ ] `Cow` used for efficient string handling
- [ ] `Box` used for recursive types

## Architecture & Design

### API Design
- [ ] API is intuitive and easy to use
- [ ] Proper abstraction boundaries
- [ ] No leaky abstractions
- [ ] Backward compatibility considered
- [ ] Error messages user-friendly

### Data Structures
- [ ] Appropriate data structures chosen
- [ ] No unnecessary data duplication
- [ ] Efficient memory layout
- [ ] Proper encapsulation
- [ ] Immutable where possible

### Dependencies
- [ ] No circular dependencies
- [ ] Dependencies are well-maintained
- [ ] License compatible
- [ ] No version conflicts
- [ ] Minimal dependency footprint

## Testing

### Unit Tests
- [ ] Tests cover happy path
- [ ] Tests cover edge cases
- [ ] Tests cover error conditions
- [ ] Tests are independent (no shared state)
- [ ] Tests are repeatable (no flakiness)

### Integration Tests
- [ ] Components work together correctly
- [ ] API contracts honored
- [ ] Data flows correctly between modules
- [ ] External dependencies mocked appropriately

### Performance Tests
- [ ] No regressions in benchmarks
- [ ] Memory usage within limits
- [ ] Response times acceptable
- [ ] Load testing performed

## Documentation

### Code Comments
- [ ] Functions have proper doc comments
- [ ] Complex algorithms explained
- [ ] Non-obvious design decisions documented
- [ ] TODOs and FIXMEs have associated issues

### API Documentation
- [ ] Public APIs documented
- [ ] Examples provided where helpful
- [ ] Usage patterns explained
- [ ] Version history maintained

### User Documentation
- [ ] New features documented
- [ ] Migration guides if needed
- [ ] Error messages documented
- [ ] Troubleshooting information

## Security

### Input Validation
- [ ] All user input validated
- [ ] No unchecked conversions
- [ ] Proper bounds checking
- [ ] Sanitization of external data

### Authentication/Authorization
- [ ] Proper access controls
- [ ] No privilege escalation
- [ ] Secure session management
- [ ] Rate limiting where appropriate

### Data Protection
- [ ] Sensitive data encrypted
- [ ] No hardcoded secrets
- [ ] Proper error messages (no info leakage)
- [ ] Secure defaults

## Maintainability

### Code Quality
- [ ] Functions are short and focused
- [ ] Classes have single responsibility
- [ ] No duplicated code
- [ ] Consistent naming conventions
- [ ] Proper use of namespaces/modules

### Build System
- [ ] Builds clean without warnings
- [ ] Cross-platform compatible
- [ ] No unnecessary rebuilds
- [ ] Proper dependency tracking
- [ ] Build artifacts organized

### Deployment
- [ ] Rollback procedure documented
- [ ] Environment variables properly handled
- [ ] Configuration externalized
- [ ] Health checks implemented
- [ ] Monitoring and logging in place

---

## Review Process

### For the Reviewer:
1. **Understand the context** - What problem is this solving?
2. **Check against checklist** - Go through each item systematically
3. **Test the changes** - Actually run the code if possible
4. **Ask questions** - Don't assume, ask for clarification
5. **Be constructive** - Critique the code, not the person
6. **Suggest alternatives** - Offer better approaches when needed
7. **Consider long-term impact** - How will this age?

### For the Author:
1. **Provide context** - Explain why the change is needed
2. **Keep changes small** - Easier to review thoroughly
3. **Respond to feedback** - Engage in discussion, don't get defensive
4. **Fix all issues** - Address every point raised
5. **Request re-review** - After making changes

### Approval Criteria:
- ✅ **Approve** - All critical issues resolved, no major concerns
- ⚠️ **Conditional Approve** - Minor issues to fix, will wait for fixes
- ❌ **Request Changes** - Major issues to address, will review again
- ⏸️ **Defer** - Needs more information or design work

---

*This checklist should be used for all code changes and stored in `teamwork/knowledge/standards/` for reference.*  
*Last Updated: [Current Date]*  
*Next Review: [Next Month]*