# Browser Automation Workflow

Use this workflow when you need to automate repetitive browser tasks, fill forms, click buttons, navigate pages, and validate UI interactions.

## Overview

Browser automation uses input automation tools to reliably interact with web pages:
- **Navigation**: Open pages, go back/forward, reload
- **Input**: Type text, click buttons, select options
- **Forms**: Fill entire forms with related data
- **File Upload**: Upload files to web applications
- **Waits**: Wait for specific conditions before proceeding

## Core Input Tools

### Click

Click an element on the page using a CSS selector or XPath.

```javascript
click("button.submit")
click("xpath=//button[contains(text(), 'Submit')]")
```

**Use cases:**
- Click buttons, links, navigation items
- Open modals and dropdowns
- Trigger form submissions

### Fill

Type text into an input field.

```javascript
fill("#email", "user@example.com")
fill("input[name='password']", "securePassword123")
```

**Use cases:**
- Enter text into text fields
- Type into search boxes
- Fill password fields

### Fill Form

Fill multiple form fields at once with a data object.

```javascript
fill_form({
  "input[name='firstName']": "John",
  "input[name='lastName']": "Doe",
  "#email": "john@example.com",
  "select[name='country']": "US"
})
```

**Use cases:**
- Multi-field forms (registration, checkout)
- Reduces multiple `fill` calls into one operation

### Select

Select an option from a dropdown.

```javascript
click("#countrySelect")
// OR use fill_form for dropdowns
fill_form({
  "select[name='country']": "United States"
})
```

### Drag

Drag an element from one location to another.

```javascript
drag("#draggable-item", { x: 100, y: 200 })
```

**Use cases:**
- Reorder items in a list
- Drag-and-drop interfaces

### Hover

Hover over an element to trigger hover states or tooltips.

```javascript
hover("button.help-icon")
```

**Use cases:**
- Reveal tooltips
- Show context menus
- Trigger hover animations

### Press Key

Press keyboard keys (including special keys like Enter, Escape, Tab).

```javascript
press_key("Enter")
press_key("Escape")
press_key("Tab", { count: 3 })  // Press Tab 3 times
```

**Use cases:**
- Submit forms with Enter
- Close modals with Escape
- Navigate with Tab

### Upload File

Upload a file to a file input field.

```javascript
upload_file("#fileInput", "/path/to/file.pdf")
```

**Use cases:**
- Upload documents
- Submit file-based forms
- Attach images or documents

### Handle Dialog

Handle JavaScript dialogs (alert, confirm, prompt).

```javascript
handle_dialog("accept")  // Click OK on alert
handle_dialog("dismiss")  // Click Cancel
handle_dialog("accept", "user input")  // Fill prompt text
```

**Use cases:**
- Close confirmation dialogs
- Provide input to prompt dialogs

## Navigation Tools

### Navigate Page

Navigate to a URL or perform browser navigation.

```javascript
navigate_page("https://example.com")
navigate_page("https://example.com", { waitUntil: "networkidle" })
```

Options:
- `waitUntil`: "load", "domcontentloaded", or "networkidle"

### New Page

Open a new tab/page.

```javascript
new_page()
```

### List Pages

List all open pages/tabs.

```javascript
list_pages()
```

### Select Page

Switch to a specific page by ID.

```javascript
select_page("page-123")
```

### Close Page

Close a specific page/tab.

```javascript
close_page()  // Close current
close_page("page-123")  // Close specific
```

### Wait For

Wait for a condition before proceeding (element appears, navigation completes, etc).

```javascript
wait_for("button.submit", { timeout: 5000 })
wait_for(2000)  // Wait 2 seconds
```

## Common Automation Patterns

### Pattern 1: Simple Form Fill and Submit

```javascript
navigate_page("https://example.com/form")

fill_form({
  "#name": "John Doe",
  "#email": "john@example.com",
  "#message": "Hello, this is a test message"
})

click("button[type='submit']")
wait_for(".success-message", { timeout: 10000 })
```

### Pattern 2: Dropdown Selection

```javascript
navigate_page("https://example.com")

click("#countryDropdown")
click("option[value='US']")
// OR
fill_form({ "select[name='country']": "United States" })
```

### Pattern 3: Dynamic Content Wait

```javascript
navigate_page("https://example.com")

click("button.load-more")
wait_for(".new-item", { timeout: 5000 })

// Now interact with newly loaded content
click(".new-item button")
```

### Pattern 4: Multi-Step Form

```javascript
// Step 1
fill_form({
  "#firstName": "John",
  "#lastName": "Doe"
})
click("button.next")

// Step 2
fill_form({
  "#email": "john@example.com"
})
click("button.next")

// Final step
click("button.submit")
wait_for(".confirmation", { timeout: 10000 })
```

### Pattern 5: Handle Modal Dialog

```javascript
navigate_page("https://example.com")

click("button.delete")
// Modal appears asking to confirm

handle_dialog("accept")  // Confirm deletion
wait_for(".deleted-message", { timeout: 5000 })
```

### Pattern 6: Login Flow

```javascript
navigate_page("https://example.com/login")

fill("#email", "user@example.com")
fill("#password", "securePassword")
click("button.login")

wait_for(".dashboard", { timeout: 10000 })
```

## Waiting Strategies

### Wait for Element Visibility

```javascript
wait_for("#loading-spinner", { timeout: 10000 })
```

### Wait for Navigation

```javascript
navigate_page("https://example.com/page2")
// Automatically waits for navigation to complete
```

### Wait for Network Idle

```javascript
navigate_page("https://example.com", { waitUntil: "networkidle" })
```

## Best Practices

1. **Use specific selectors**: Prefer IDs and data-test attributes over generic selectors
2. **Add appropriate waits**: After navigation or clicking, wait for expected elements
3. **Handle errors gracefully**: Check if elements exist before interacting
4. **Use data-testid attributes**: When available, they're more reliable than class names
5. **Test on multiple browsers**: Automation may work on one browser but fail on another
6. **Avoid hard waits when possible**: Use `wait_for` instead of fixed delays
7. **Keep sequences short**: Break complex flows into smaller, testable steps

## Debugging Automation Issues

If automation fails:

1. Use `take_screenshot()` to see the current page state
2. Use `take_snapshot()` for DOM structure
3. Use `evaluate_script()` to check JavaScript state
4. Use `list_console_messages()` to check for errors
5. Verify selectors work in browser DevTools console first
