---
name: "chrome-devtools-mcp"
displayName: "Chrome DevTools MCP"
description: "Control and inspect a live Chrome browser from Kiro using Chrome DevTools MCP tools for automation, debugging, and performance analysis."
keywords:
  - "chrome"
  - "devtools"
  - "mcp"
  - "browser"
  - "debugging"
  - "automation"
  - "performance"
  - "network"
  - "puppeteer"
mcpServers:
  - "chrome-devtools"
---

# Onboarding

## Step 1: Validate prerequisites

Before using **Chrome DevTools MCP**, ensure the following are installed and available in your environment:

- **Node.js** v20.19 or newer (latest maintenance LTS is recommended).
  - Verify with: `node -v`
- **npm** installed and available on your PATH.
  - Verify with: `npm -v`
- **Google Chrome** (stable channel or newer) installed on this machine.

If any of these checks fail, install or upgrade the tools before proceeding.

## Step 2: Choose how Chrome is controlled

There are two primary ways to use Chrome DevTools MCP from Kiro:

1. **Let the MCP server launch Chrome automatically**
   - Recommended for simple local debugging and automation.
   - Use the default configuration in `mcp.json` which runs:
     - `npx chrome-devtools-mcp@latest`
   - Optionally pass flags like `--headless=true`, `--isolated=true`, or `--channel=beta` via the MCP server args.

2. **Connect to an already running Chrome instance (remote debugging)**
   - Recommended when you want to:
     - Share state between manual browsing and agent-driven testing.
     - Avoid issues from WebDriver-controlled sessions (e.g. logins blocked).
     - Run Chrome outside of any sandbox your MCP client might use.
   - Start Chrome with remote debugging enabled and a dedicated user data dir.

## Step 3: (Optional) Enable auto-connect to existing Chrome (Chrome >= 144)

If your Chrome version supports it and you want the MCP server to automatically connect to a running Chrome profile:

1. In Chrome, open `chrome://inspect/#remote-debugging` and enable remote debugging.
2. Adjust the MCP server args in `mcp.json` to include:
   - `--autoConnect`
   - `--channel=<stable|beta|dev|canary>`

## Step 4: Security considerations

- `chrome-devtools-mcp` exposes browser content to the MCP client and to Kiro's agent.
- Avoid loading sensitive accounts or private data in any Chrome profile used with this power.
- Prefer using a dedicated Chrome profile (via `--user-data-dir` or `--isolated=true`) for testing.

# Best Practices and Workflows

## Performance analysis workflow

Use this when you want to understand page performance characteristics (LCP, CLS, long tasks):

1. Open or navigate the target page using the navigation tools.
2. Start a performance trace with `performance_start_trace`.
3. Interact with the page (or let the agent perform key interactions).
4. Stop the trace using `performance_stop_trace`.
5. Run `performance_analyze_insight` to get actionable performance insights.

## DOM and UI debugging workflow

Use this when investigating broken UI, click handlers, or form flows:

1. Use `list_pages` and `select_page` to choose the active tab.
2. Navigate with `navigate_page` if needed.
3. Use input automation tools to reproduce user flows.
4. Capture the state with `take_screenshot` or `take_snapshot`.
5. If issues are JavaScript-related, use `evaluate_script` or console tools.

## Network debugging workflow

Use this when APIs are failing or data is not loading:

1. Reproduce the issue using `navigate_page` and input automation tools.
2. Use `list_network_requests` to inspect recent network activity.
3. Use `get_network_request` on suspicious requests.
4. Combine with `evaluate_script` for in-page error handling checks.

## Emulation and environment testing

Use emulation tools before running performance or correctness checks in alternate environments.

## When Kiro should activate this power

Kiro should load this power when the user:
- Mentions **Chrome DevTools**, **DevTools MCP**, or **Chrome automation**.
- Asks to "control the browser", "navigate a site", or "click/fill forms".
- Requests **performance analysis**, **web vitals debugging**, or **network debugging**.
- Wants DOM snapshots, screenshots, or console logs for a web page.
