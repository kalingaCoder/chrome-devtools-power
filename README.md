# Chrome DevTools MCP Power for Kiro

A Kiro Power for Chrome DevTools MCP that enables browser automation, debugging, performance analysis, and network inspection through Chrome DevTools Protocol.

## Quick Start

1. Ensure Node.js v20.19+ and Google Chrome are installed
2. Install this power in Kiro from the Powers panel
3. Configure `mcp.json` with your preferred Chrome launch options

## Features

- Browser automation and control
- Performance tracing and Web Vitals analysis
- Network request inspection
- DOM debugging and snapshots
- Console message capture
- Device emulation and viewport testing

## Configuration

See `POWER.md` for detailed setup and workflow instructions.

## File Structure

```
power-chrome-devtools-mcp/
ÃÄÄ POWER.md       # Main documentation with frontmatter, onboarding, and workflows
ÃÄÄ mcp.json       # MCP server configuration
ÃÄÄ README.md      # Quick reference guide
ÀÄÄ steering/      # Optional: Workflow-specific guidance files
```

## Installation

1. Clone or add this power directory to your Kiro workspace
2. In Kiro, go to Powers > Add power from Local Path
3. Select the `power-chrome-devtools-mcp` directory
4. Test by mentioning "Chrome DevTools" or "browser automation" in a conversation

## Troubleshooting

- Verify Node.js and npm versions: `node -v && npm -v`
- Ensure Google Chrome is installed: Open Chrome or check Program Files
- Check MCP logs in Kiro for connection issues
