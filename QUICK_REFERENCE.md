# Study Sync - Quick Reference Card

## 🎨 Import These Files Every Time

```dart
import '../../widgets/theme/app_colors.dart';
import '../../widgets/theme/app_constants.dart';
import '../../widgets/theme/app_widgets.dart';
import '../../widgets/theme/app_animations.dart';
```

---

## 🎯 Common Tasks

### Task 1: Set Background Color (Theme-Aware)
```dart
backgroundColor: Theme.of(context).brightness == Brightness.dark 
  ? AppColors.darkBg 
  : AppColors.lightBg,
```

### Task 2: Add Consistent Padding
```dart
// Instead of: padding: const EdgeInsets.all(24.0)
padding: AppConstants.paddingLg,  // 24px all sides
```

### Task 3: Create a Primary Button
```dart
AppWidgets.primaryButton(
  label: "Save Task",
  onPressed: () { /* action */ },
  isLoading: _isLoading,
)
```

### Task 4: Show Empty State
```dart
if (items.isEmpty)
  AppWidgets.emptyState(
    context: context,
    icon: Icons.task_rounded,
    title: "No Tasks",
    description: "Create your first task",
    actionButton: AppWidgets.primaryButton(
      label: "Add Task",
      onPressed: _addTask,
    ),
  )
else
  ListView(...)
```

### Task 5: Add Fade Animation to Screen Content
```dart
AppAnimations.fadeAnimation(
  child: screenContent,
)
```

### Task 6: Animate List Items with Slide
```dart
ListView.builder(
  itemBuilder: (context, index) => AppAnimations.slideAnimation(
    child: taskCard,
  ),
)
```

### Task 7: Display Error Message
```dart
AppWidgets.errorMessage(
  message: "Failed to save",
  onDismiss: () => setState(() => _error = null),
)
```

### Task 8: Create Stat Card (Level/Streak/Points)
```dart
AppWidgets.statCard(
  context: context,
  value: "5",
  label: "Level",
  icon: Icons.star_rounded,
  iconColor: AppColors.levelUp,
)
```

---

## 📏 Spacing Quick Reference

| Use | Size | Constant |
|-----|------|----------|
| Tiny gap | 4px | `AppConstants.spacingXs` |
| Small gap | 8px | `AppConstants.spacingSm` |
| Normal gap | 16px | `AppConstants.spacingMd` |
| Large gap | 24px | `AppConstants.spacingLg` |
| Extra large | 32px | `AppConstants.spacingXl` |
| Hero section | 48px | `AppConstants.spacing2xl` |

---

## 🎨 Color Quick Reference

| Purpose | Color | Constant |
|---------|-------|----------|
| Primary action | Purple | `AppColors.primary` |
| Success | Green | `AppColors.success` |
| Error | Red | `AppColors.error` |
| Warning | Orange | `AppColors.warning` |
| Dark background | Navy | `AppColors.darkBg` |
| Dark card | Darker navy | `AppColors.darkCardBg` |
| Dark text | Off-white | `AppColors.darkText` |

---

## 🔘 Button Reference

```dart
// Primary (prominent, use for main action)
AppWidgets.primaryButton(
  label: "Save",
  onPressed: onPressed,
)

// Secondary (less prominent, use for cancel)
AppWidgets.secondaryButton(
  label: "Cancel",
  onPressed: onPressed,
)
```

---

## 📝 Form Pattern

```dart
SingleChildScrollView(
  child: Padding(
    padding: AppConstants.paddingLg,
    child: Column(
      children: [
        // Error if exists
        if (_error != null)
          AppWidgets.errorMessage(message: _error!),
        
        SizedBox(height: AppConstants.spacingLg),
        
        // Input fields with consistent styling
        TextField(
          decoration: InputDecoration(
            labelText: "Field Name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
          ),
        ),
        
        SizedBox(height: AppConstants.spacingLg),
        
        // Buttons (primary first, secondary second)
        AppWidgets.primaryButton(label: "Save", onPressed: _save),
        SizedBox(height: AppConstants.spacingMd),
        AppWidgets.secondaryButton(label: "Cancel", onPressed: _cancel),
      ],
    ),
  ),
)
```

---

## 📱 List Pattern

```dart
Column(
  children: [
    // Header
    AppWidgets.sectionHeader(
      context: context,
      title: "My Items",
      actionLabel: items.isEmpty ? null : "Edit",
      onAction: items.isEmpty ? null : _edit,
    ),
    
    SizedBox(height: AppConstants.spacingMd),
    
    // Empty state or list
    items.isEmpty
      ? AppWidgets.emptyState(...)
      : ListView.builder(
          itemBuilder: (context, index) => AppAnimations.slideAnimation(
            child: _buildItemCard(items[index]),
          ),
        ),
  ],
)
```

---

## 🎬 Animation Quick Reference

| Animation | Use Case | Code |
|-----------|----------|------|
| Fade | Screen entry | `AppAnimations.fadeAnimation(child:)` |
| Slide | List items | `AppAnimations.slideAnimation(child:)` |
| Scale | Button press | `AppAnimations.scaleAnimation(child:)` |
| Bounce | Celebration | `AppAnimations.bounceAnimation(child:)` |
| Pulse | Attention | `AppAnimations.pulseAnimation(child:)` |
| Flip | Checkbox | `AppAnimations.flipAnimation(child:)` |
| Rotate | Loading | `AppAnimations.rotationAnimation(child:)` |
| Shake | Error | `AppAnimations.shakeAnimation(child:)` |

---

## ✅ Pre-Implementation Checklist

- [ ] Imported all 4 design files
- [ ] Using AppConstants for spacing (no hardcoded values)
- [ ] Using AppColors for all colors (no Color(0xFF...))
- [ ] Theme-aware colors with brightness check
- [ ] Empty state for no data
- [ ] Dark mode support
- [ ] Animations on important actions
- [ ] Error message styling consistent
- [ ] Button styling consistent
- [ ] Tested on light and dark mode

---

## 🧪 Testing Commands

### Run app with light theme
```bash
flutter run
```

### Force dark mode testing
In DevTools, toggle dark mode in settings

### Test at 200% text scaling
Device settings → Accessibility → Text size

### Test on different screen sizes
Flutter DevTools → Device simulation

---

## 🔗 File References

| File | Purpose | Key Components |
|------|---------|-----------------|
| `app_colors.dart` | All colors | primary, success, error, darkBg |
| `app_constants.dart` | Spacing/sizing | spacing*, radius*, button* |
| `app_widgets.dart` | UI components | primaryButton, emptyState, cards |
| `app_animations.dart` | Animations | fadeAnimation, slideAnimation, etc |

---

## ⚠️ Common Mistakes to Avoid

```dart
// ❌ DON'T: Hard-coded colors
backgroundColor: Color(0xFF5B4FE9)

// ✅ DO: Use design system
backgroundColor: AppColors.primary

// ❌ DON'T: Hard-coded spacing
padding: EdgeInsets.all(24)

// ✅ DO: Use constants
padding: AppConstants.paddingLg

// ❌ DON'T: Arbitrary border radius
borderRadius: BorderRadius.circular(8)

// ✅ DO: Use design constant
borderRadius: BorderRadius.circular(AppConstants.radiusMd)

// ❌ DON'T: Forget dark mode
backgroundColor: Colors.white

// ✅ DO: Use theme-aware color
backgroundColor: isDark ? AppColors.darkCardBg : Colors.white

// ❌ DON'T: Skip empty states
items.isEmpty ? SizedBox() : ListView(...)

// ✅ DO: Use component
items.isEmpty ? AppWidgets.emptyState(...) : ListView(...)
```

---

## 📞 When You're Stuck

1. **Can't find a component?**
   - Check `app_widgets.dart` for available components
   - Look at DESIGN_SYSTEM.md for documentation

2. **What color should I use?**
   - Check `app_colors.dart` for available colors
   - Look at app_theme.dart to see how they're used

3. **How much padding?**
   - Use AppConstants.spacing* constants
   - Check AppConstants.padding* for standard presets

4. **Need an animation?**
   - Check `app_animations.dart` for 8 types
   - See home_dashboard.dart for usage examples

5. **Working on a specific screen?**
   - Check IMPLEMENTATION_GUIDE.md for screen-specific guidance
   - Look at similar completed screens as examples

---

## 🎉 You're Ready!

You now have everything you need to implement the remaining screens with consistency, accessibility, and style. Just:

1. Import the design files
2. Follow the patterns shown above
3. Use the components provided
4. Reference completed screens for examples
5. Run through the checklist before finishing

**Happy coding!** 🚀

---

**Last Updated**: August 2026
**Quick Reference Version**: 1.0
