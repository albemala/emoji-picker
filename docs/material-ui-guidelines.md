# Base UI Guidelines

These guidelines provide the foundation for consistent UI development across all Flutter projects. They focus on standard Material Design practices, spacing scales, and common component patterns.

## Theme & Colors

**Rule**: Always use Material Design theme properties via `Theme.of(context)` for colors and text styles. **Never hardcode hex colors or direct text styles.**

### Theme Access Examples
```dart
// Text styles
Theme.of(context).textTheme.headlineLarge
Theme.of(context).textTheme.titleMedium
Theme.of(context).textTheme.bodyMedium

// Colors
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
Theme.of(context).colorScheme.onSurface
```

---

## Design Best Practices

### Spacing Scale
Use a consistent 8px grid. All padding, margins, and gaps must use multiples of 8:

| Scale | Use Case |
|-------|----------|
| 8px | Tight spacing between related elements |
| 16px | Standard padding, gaps between sections |
| 24px | Larger gaps, section separators |
| 32px | Major section spacing |
| 48px | Page-level spacing |

**Implementation Hint**:
```dart
Padding(padding: const EdgeInsets.all(16), child: ...)
Column(spacing: 16, children: [...])
```

### Typography Hierarchy
Always use theme text styles to ensure consistency and support for accessibility (dynamic text sizes).

| Style | Use Case |
|-------|----------|
| headlineLarge/Medium | Page and section headers |
| titleLarge/Medium | Subsection headers, prominent labels |
| bodyLarge/Medium | Standard body text, descriptions |
| labelLarge/Medium | Captions, small buttons, metadata |

---

## layout Principles
- **Vertical Rhythm**: Maintain consistent vertical spacing using the 8px scale.
- **Alignment**: Elements should snap to the 8px grid.
- **Grouping**: Use 16px spacing between items in a group; use 24-32px to separate distinct groups.
- **Constraints**: Use `ConstrainedBox` or `SizedBox` to limit widths on large screens (e.g., max 400-600px for forms/dialogs).

---

## Component Patterns

### Buttons
- **Primary Action**: Use `FilledButton` or `FilledButton.icon`.
- **Secondary Action**: Use `OutlinedButton` or `TextButton`.
- **Toolbar Action**: Use `IconButton` with `_outlined` variants by default.

### Text Input
- Always include a descriptive label/title.
- Use built-in validation.
- Ensure clear error states using `Theme.of(context).colorScheme.error`.

### Dialogs
- Follow the `AlertDialog` pattern.
- Content should be constrained (e.g., `maxWidth: 400`).
- Always provide a clear way to dismiss/close the dialog.

---

## Common Mistakes to Avoid
❌ **Hardcoding colors**: e.g., `Colors.blue` or `Color(0xFF...)`.  
✅ **Use Theme**: `Theme.of(context).colorScheme.primary`.

❌ **Hardcoding font sizes**: e.g., `fontSize: 18`.  
✅ **Use Theme**: `Theme.of(context).textTheme.titleMedium`.

❌ **Arbitrary spacing**: e.g., `padding: EdgeInsets.all(10)`.  
✅ **Use 8px scale**: `padding: const EdgeInsets.all(16)`.

❌ **Monolithic Widgets**: Putting all UI logic in one huge `build` method.  
✅ **Sub-componentization**: Break the UI into small, reusable widgets with single responsibilities.
