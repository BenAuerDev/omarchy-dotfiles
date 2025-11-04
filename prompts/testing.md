## Instructions for Writing Tests

Write comprehensive tests that verify actual functionality and behavior, not implementation details.

### Requirements:
1. **Test real behavior**: Verify the actual functionality works as expected, not just that functions are called
2. **Use real dependencies when possible**: Avoid mocks unless absolutely necessary (external APIs, file I/O, etc.). Prefer real implementations, test doubles, or in-memory alternatives
3. **Test user workflows**: Focus on end-to-end scenarios that users would actually encounter
4. **Verify outcomes**: Assert on actual results, state changes, or side effects, not just that methods were called
5. **Test edge cases**: Include boundary conditions, error cases, and invalid inputs that could occur in real usage
6. **Integration over isolation**: Prefer integration tests that test components working together over isolated unit tests with heavy mocking
7. **Meaningful assertions**: Each test should verify something important about the system's behavior

### Avoid:
- Tests that only verify methods were called (mock verification)
- Tests that mock everything and don't test real behavior
- Tests that pass by accident or test trivial code paths
- Over-mocking that makes tests brittle and disconnected from reality

### Focus on:
Does this actually work? What happens when a real user does X?

---

## Feature to Test


