# Performance Analysis Workflow

Use this workflow when you need to understand page performance characteristics, identify bottlenecks, and optimize Core Web Vitals metrics.

## Overview

Performance analysis uses Chrome DevTools traces to record real browser behavior and extract actionable insights about:
- **Largest Contentful Paint (LCP)**: When the main content is visible
- **Cumulative Layout Shift (CLS)**: Visual stability issues
- **First Input Delay (FID)**: Responsiveness to user input
- **Long Tasks**: JavaScript execution that blocks the main thread

## Workflow Steps

### Step 1: Navigate to the target page

Use `navigate_page` to open the URL you want to analyze.

```javascript
// Example: Navigate to a target URL
navigate_page("https://example.com")
```

### Step 2: Prepare the page for analysis

- Let the page fully load
- Close any popup dialogs with `handle_dialog`
- Resize the viewport with `resize_page` if testing responsive performance
- Consider emulating specific devices with `emulate` (e.g., mobile, tablet)

### Step 3: Start the performance trace

Use `performance_start_trace` to begin recording performance data. This captures JavaScript execution, rendering, network activity, and more.

```javascript
performance_start_trace()
```

### Step 4: Reproduce the interaction or wait for metrics

Perform the key user interactions you want to measure:
- Scroll the page
- Click buttons using `click`
- Fill forms with `fill`
- Upload files with `upload_file`

Alternatively, wait for the page to settle (usually 10-30 seconds) to capture First Paint and LCP metrics.

### Step 5: Stop the trace

Use `performance_stop_trace` to finish recording.

```javascript
performance_stop_trace()
```

### Step 6: Analyze and get insights

Use `performance_analyze_insight` to extract actionable insights from the trace data.

```javascript
performance_analyze_insight()
```

The tool will return:
- Performance scores and metrics
- Identified bottlenecks
- Actionable recommendations
- JavaScript execution time breakdown
- Network-related delays

## Best Practices

### Mobile vs. Desktop Performance

Test both:
- **Desktop**: Emulate modern laptops with `emulate("desktop")`
- **Mobile**: Emulate 4G throttling and mobile devices with `emulate("mobile")`

Mobile networks and devices typically show worse performance than desktop, so testing both perspectives is important.

### Avoiding False Positives

- **Cold vs. Warm Loads**: First visit (cold) has no cache; repeat visits (warm) are faster. Test both.
- **Network Throttling**: Use `emulate` to simulate realistic network conditions (3G, 4G, 5G).
- **Multiple Runs**: Perform 3+ trace runs to average out variance and identify consistent bottlenecks.

### Common Performance Issues

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **Long tasks** | Script execution > 50ms blocking main thread | Split JavaScript into smaller tasks or use Web Workers |
| **Large images** | High LCP, slow downloads | Compress images, use modern formats (WebP), serve responsive images |
| **Render-blocking CSS/JS** | Resources delay First Paint | Defer non-critical CSS, lazy-load JavaScript |
| **Layout thrashing** | High CLS, jank on scroll | Avoid style changes in tight loops, use `requestAnimationFrame` |
| **Slow API responses** | Network waterfall shows delays | Cache results, optimize server response time, use CDN |

## Example: Full Performance Analysis

```javascript
// 1. Navigate to the page
navigate_page("https://example.com")

// 2. Emulate mobile device
emulate("mobile")

// 3. Start trace
performance_start_trace()

// 4. Scroll the page and wait for interactions
scroll()
wait_for(3000)  // Let page settle

// 5. Stop trace
performance_stop_trace()

// 6. Get insights
performance_analyze_insight()
```

## When to Use This Workflow

- Optimizing page speed for SEO or UX
- Investigating performance complaints from users
- Before and after comparisons when optimizing assets
- Benchmarking against competitors
- Testing performance across different devices and networks
