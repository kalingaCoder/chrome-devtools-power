# Debugging Workflows

Use these workflows when investigating JavaScript errors, DOM issues, console logs, and network problems.

## Overview

Debugging tools help you:
- Inspect DOM structure and CSS
- View console logs and errors
- Execute JavaScript directly
- Analyze network requests and responses
- Detect JavaScript runtime errors

## Debugging Tools

### Take Screenshot

Capture a visual screenshot of the current page.

```javascript
take_screenshot()
```

Returns:
- Base64-encoded image
- Useful for visual inspection of UI issues
- Better than snapshots for checking visual layout

**Use cases:**
- Verify UI is rendering correctly
- Check if elements are visible/invisible
- Document page state for debugging

### Take Snapshot

Get the DOM structure (HTML) of the current page.

```javascript
take_snapshot()
```

Returns:
- Complete HTML of the page
- Useful for inspecting element structure
- Helps verify elements exist and have expected attributes

**Use cases:**
- Check if elements are in the DOM
- Verify expected structure
- Find selectors for automation

### Evaluate Script

Execute arbitrary JavaScript in the page context.

```javascript
evaluate_script("document.title")
evaluate_script("window.location.href")
evaluate_script("JSON.stringify(localStorage)")
```

Returns:
- Result of JavaScript execution
- Can return primitives or serializable objects

**Use cases:**
- Get page variables
- Check application state
- Execute custom logic
- Verify localStorage/sessionStorage

### List Console Messages

Get all console logs, warnings, and errors.

```javascript
list_console_messages()
```

Returns:
- All console output since page load
- Includes type (log, warn, error, info)

**Use cases:**
- Find JavaScript errors
- Review application logs
- Check for warnings

### Get Console Message

Get detailed info about a specific console message.

```javascript
get_console_message(0)  // Get first message
```

Returns:
- Full message content
- Stack traces for errors
- Additional context

## Common Debugging Patterns

### Pattern 1: Check for JavaScript Errors

```javascript
navigate_page("https://example.com")

// Get all console messages
list_console_messages()

// Check for errors in results
// If errors found, can investigate further
get_console_message(error_index)
```

### Pattern 2: Verify Element Exists

```javascript
take_snapshot()
// Inspect HTML output for element

evaluate_script("document.querySelector('button.submit') !== null")
// Returns true if element exists
```

### Pattern 3: Check Page State

```javascript
navigate_page("https://example.com/app")

// Check if app is loaded
evaluate_script("typeof window.app !== 'undefined'")

// Get current user
evaluate_script("window.app?.user?.name")

// Check authentication
evaluate_script("localStorage.getItem('auth_token') !== null")
```

### Pattern 4: Inspect Network Requests

```javascript
navigate_page("https://example.com")

// Get network requests
list_network_requests()

// Inspect specific request
get_network_request(0)
```

### Pattern 5: Debug Form Submission

```javascript
navigate_page("https://example.com/form")
take_screenshot()

fill("#email", "test@example.com")
fill("#name", "John")

// Check form state before submit
evaluate_script(`
  const form = document.querySelector('form');
  ({
    email: form.elements.email.value,
    name: form.elements.name.value
  })
`)

click("button[type='submit']")

// Check for errors
list_console_messages()
```

### Pattern 6: Verify Redirect

```javascript
navigate_page("https://example.com/old-page")

// Check current URL
evaluate_script("window.location.href")

// Take screenshot to verify redirect
take_screenshot()
```

### Pattern 7: Check LocalStorage/SessionStorage

```javascript
evaluate_script("JSON.stringify(localStorage)")
evaluate_script("JSON.stringify(sessionStorage)")

// Get specific item
evaluate_script("localStorage.getItem('user_id')")
```

### Pattern 8: Inspect API Responses

```javascript
navigate_page("https://example.com/api-consumer")

// Trigger API call
click("button.load-data")

// Check network requests
list_network_requests()

// Get specific request and response
get_network_request(0)
// Includes response body and headers
```

## Debugging DOM and CSS

### Find Element Information

```javascript
take_snapshot()
// Search output for element class names, IDs, data attributes

// Then use evaluate_script to get more info
evaluate_script(`
  const elem = document.querySelector('#my-element');
  ({
    visible: elem.offsetHeight > 0,
    tagName: elem.tagName,
    classes: elem.className,
    text: elem.textContent,
    computedStyle: window.getComputedStyle(elem).display
  })
`)
```

### Check CSS Display Property

```javascript
evaluate_script(`
  const elem = document.querySelector('button.hidden');
  window.getComputedStyle(elem).display
  // Returns "none" if hidden
`)
```

### Count Elements

```javascript
evaluate_script(`
  document.querySelectorAll('.item').length
`)
```

## Debugging Dynamic Content

### Wait and Verify Content Loads

```javascript
navigate_page("https://example.com")

// Wait for content
wait_for(".dynamic-content", { timeout: 5000 })

// Verify it loaded
take_snapshot()

// Check if visible
evaluate_script(`
  document.querySelector(".dynamic-content").offsetHeight > 0
`)
```

### Handle Lazy-Loaded Images

```javascript
navigate_page("https://example.com/gallery")

// Scroll to trigger lazy loading
evaluate_script("window.scrollBy(0, window.innerHeight)")

// Wait for images
wait_for("img[src*='real-image']", { timeout: 5000 })
```

## Network Debugging

### List All Requests

```javascript
navigate_page("https://example.com")

list_network_requests()
```

Returns:
- All HTTP requests made
- Method, URL, status code
- Request/response headers
- Response body (for JSON/text)

### Analyze Failed Requests

```javascript
navigate_page("https://example.com")

const requests = list_network_requests()

// Look for failed requests (status >= 400)
// Use get_network_request() to get details
```

### Check API Response

```javascript
navigate_page("https://example.com/api")

click("button.fetch-data")

const requests = list_network_requests()
const apiRequest = requests.find(r => r.url.includes('/api/data'))

get_network_request(apiRequest.id)
// Check response body and headers
```

## Performance Debugging

### Check Main Thread Activity

```javascript
performance_start_trace()
// Perform actions
performance_stop_trace()

// Get trace data
performance_analyze_insight()
// Look for long tasks blocking main thread
```

### Monitor Resource Loading

```javascript
list_network_requests()
// Check for:
// - Large resources
// - Slow responses
// - Failed requests
// - Waterfall of requests (serial vs parallel)
```

## Best Practices

1. **Check console messages first**: Most JavaScript issues show up as errors/warnings
2. **Use snapshots for inspection**: When you need to see exact HTML structure
3. **Use screenshots for visual verification**: When checking layout/styling
4. **Combine tools**: Use snapshot + console messages + evaluate_script together
5. **Check browser compatibility**: What works in one browser might fail in another
6. **Use try-catch in evaluate_script**: For safer JavaScript execution

## Tips for Efficient Debugging

- Start with `take_screenshot()` to see the current state
- Use `list_console_messages()` to catch errors early
- Use `take_snapshot()` to verify expected DOM structure
- Use `evaluate_script()` to check application state
- Check network requests to verify API calls
- Use performance tools to identify slow operations
