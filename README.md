# Chrome DevTools MCP Power for Kiro

A Kiro Power for Chrome DevTools MCP that enables browser automation, debugging, performance analysis, and network inspection through Chrome DevTools Protocol.

## Quick Start

1. Ensure Node.js v20.19+ and Google Chrome are installed
2. Install this power in Kiro from the Powers panel
3. Configure `mcp.json` with your preferred Chrome launch options

## Features

- **Browser automation**: Click, fill forms, navigate pages, upload files
- **Performance analysis**: Trace page load, analyze Core Web Vitals (LCP, CLS, FID)
- **Network debugging**: Inspect HTTP requests, check API responses
- **DOM debugging**: Take screenshots, inspect HTML, check console logs
- **Device emulation**: Test on mobile, tablet, or custom viewports

## What's Included

- **POWER.md**: Complete documentation with setup instructions, best practices, and workflow guides
- **mcp.json**: MCP server configuration (ready to use with default Chrome launch)
- **steering/** folder: Detailed workflow guides for specific tasks:
  - `performance-analysis.md` - Web performance optimization guides
  - `browser-automation.md` - Form filling, clicking, navigation examples
  - `debugging-workflows.md` - Console logs, DOM inspection, error handling
  - `network-debugging.md` - API debugging, request inspection, CORS issues

## Activation Keywords

Kiro automatically loads this power when you mention:
- "Chrome DevTools", "DevTools MCP", "Chrome automation"
- "browser control", "navigate a site", "click buttons"
- "performance analysis", "Web Vitals", "network debugging"
- "browser testing", "web scraping", "form automation"
- "debugging", "troubleshooting", "inspecting a website"

## Installation

1. Clone or add this power directory to your Kiro workspace
2. In Kiro, go to Powers > Add power from Local Path
3. Select the `power-chrome-devtools-mcp` directory
4. Test by mentioning "Chrome DevTools" or "browser automation" in a conversation

## Configuration

See **POWER.md** for:
- Prerequisites and validation steps
- Chrome launch options (automatic vs. remote debugging)
- Security considerations
- Detailed workflow guides with code examples

## Example Workflows

### Performance Analysis
1. Navigate to page
2. Start performance trace with `performance_start_trace`
3. Perform user actions
4. Stop trace and analyze with `performance_analyze_insight`

### Browser Automation
1. Navigate to page with `navigate_page`
2. Fill form with `fill_form`
3. Click submit with `click`
4. Wait for results with `wait_for`

### Network Debugging
1. List network requests with `list_network_requests`
2. Inspect specific requests with `get_network_request`
3. Check response bodies and headers
4. Identify failed (4xx, 5xx) or slow requests

## Troubleshooting

- **Node.js not found**: Verify installation with `node -v` (requires v20.19+)
- **Chrome not launching**: Check Chrome is installed; enable `--isolated` flag in mcp.json for sandbox issues
- **Remote debugging fails**: Enable `chrome://inspect/#remote-debugging` and use `--autoConnect` flag
- **Permission issues**: Use `--user-data-dir` with a dedicated profile directory

## Resources

- [Chrome DevTools MCP GitHub](https://github.com/ChromeDevTools/chrome-devtools-mcp)
- [Tool Reference](https://github.com/ChromeDevTools/chrome-devtools-mcp/blob/main/docs/tool-reference.md)
- [Troubleshooting Guide](https://github.com/ChromeDevTools/chrome-devtools-mcp/blob/main/docs/troubleshooting.md)
- [Kiro Powers Documentation](https://kiro.dev/docs/powers/)
