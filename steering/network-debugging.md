# Network Debugging Workflow

Use this workflow when investigating network issues, API failures, slow responses, and data loading problems.

## Overview

Network debugging helps you:
- Monitor HTTP requests and responses
- Identify failed requests
- Analyze response timing and payloads
- Debug API integration issues
- Check headers and authentication

## Network Tools

### List Network Requests

Get all network requests made by the page.

```javascript
list_network_requests()
```

Returns array with:
- URL
- HTTP method (GET, POST, etc)
- Status code
- Request size
- Response time
- Content type

**Use cases:**
- See all API calls a page makes
- Find failed requests (status >= 400)
- Identify slow requests
- Check request sequence

### Get Network Request

Get detailed information about a specific request.

```javascript
get_network_request(0)  // First request
get_network_request("request-id")  // By ID
```

Returns:
- Full request headers
- Request body
- Response headers
- Response body (for JSON/text)
- Timing details
- Cookies

**Use cases:**
- Inspect request/response details
- Check authentication headers
- Analyze response payload
- Verify request parameters

## Common Network Debugging Patterns

### Pattern 1: Find Failed Requests

```javascript
navigate_page("https://example.com")

// Perform action that might fail
click("button.load-data")
wait_for(2000)

// Get all network requests
const requests = list_network_requests()

// Find failed requests (status >= 400)
const failed = requests.filter(r => r.status >= 400)

if (failed.length > 0) {
  // Inspect first failed request
  get_network_request(failed[0].id)
}
```

### Pattern 2: Check API Response Body

```javascript
navigate_page("https://example.com/app")

// Trigger API call
click("button.fetch-data")
wait_for(2000)

// Get requests
const requests = list_network_requests()

// Find API request
const apiReq = requests.find(r => r.url.includes('/api/'))

if (apiReq) {
  const details = get_network_request(apiReq.id)
  // details.responseBody contains JSON response
}
```

### Pattern 3: Verify Authentication Headers

```javascript
navigate_page("https://api.example.com/protected")

const requests = list_network_requests()
const apiRequest = requests[0]

const details = get_network_request(apiRequest.id)

// Check if Authorization header exists
if (details.requestHeaders['Authorization']) {
  console.log("Auth header present")
} else {
  console.log("Missing auth header!")
}
```

### Pattern 4: Monitor Sequential API Calls

```javascript
navigate_page("https://example.com")

// Perform action triggering multiple API calls
click("button.process")

// Get requests in order
const requests = list_network_requests()

// Analyze sequence
for (const req of requests) {
  if (req.url.includes('/api/')) {
    console.log(`${req.method} ${req.url} - ${req.status}`)
  }
}
```

### Pattern 5: Check Response Size

```javascript
const requests = list_network_requests()

// Find large responses
const large = requests.filter(r => r.responseSize > 1000000)  // > 1MB

if (large.length > 0) {
  console.log("Large responses detected - consider optimization")
  large.forEach(r => console.log(`${r.url}: ${r.responseSize} bytes`))
}
```

### Pattern 6: Analyze Timing

```javascript
const requests = list_network_requests()

// Find slow requests (> 2 seconds)
const slow = requests.filter(r => r.time > 2000)

if (slow.length > 0) {
  console.log("Slow requests found:")
  slow.forEach(r => {
    get_network_request(r.id)  // Get detailed timing
  })
}
```

### Pattern 7: Check Content Type

```javascript
const requests = list_network_requests()

// Find non-JSON API responses
requests.forEach(r => {
  if (r.url.includes('/api/')) {
    const details = get_network_request(r.id)
    const contentType = details.responseHeaders['content-type']
    if (!contentType?.includes('application/json')) {
      console.warn(`Unexpected content-type: ${contentType}`)
    }
  }
})
```

### Pattern 8: CORS Issue Investigation

```javascript
navigate_page("https://example.com")

// Trigger request that might have CORS issue
click("button.fetch-external-api")
wait_for(2000)

const requests = list_network_requests()

// Look for requests with CORS-related status or errors
const corsIssues = requests.filter(r => 
  r.status === 0 || 
  r.url.includes('http') && !r.url.includes('example.com')
)

if (corsIssues.length > 0) {
  console.log("Potential CORS issues detected")
  corsIssues.forEach(r => get_network_request(r.id))
}
```

## Network Request Structure

When you get a request, it contains:

```javascript
{
  id: "request-123",
  url: "https://api.example.com/data",
  method: "GET",
  status: 200,
  statusText: "OK",
  contentType: "application/json",
  requestSize: 512,
  responseSize: 2048,
  time: 250,  // milliseconds
  requestHeaders: {
    "Authorization": "Bearer token...",
    "Accept": "application/json",
    ...
  },
  responseHeaders: {
    "content-type": "application/json",
    "cache-control": "max-age=3600",
    ...
  },
  requestBody: "...",  // if POST/PUT
  responseBody: "{\"data\": ...}"  // if applicable
}
```

## Debugging Common Network Issues

### Issue: 401 Unauthorized

```javascript
// Check if auth token is being sent
const requests = list_network_requests()
const apiReq = requests[0]
const details = get_network_request(apiReq.id)

if (!details.requestHeaders['Authorization']) {
  console.log("Missing authorization header")
} else {
  console.log("Auth header present but server rejected")
  console.log(details.responseBody)
}
```

### Issue: 404 Not Found

```javascript
// Check URL being requested
const requests = list_network_requests()
const notFound = requests.find(r => r.status === 404)

if (notFound) {
  console.log("Endpoint not found:", notFound.url)
  // May indicate wrong API base URL or endpoint path
}
```

### Issue: 500 Server Error

```javascript
// Check error response from server
const requests = list_network_requests()
const error = requests.find(r => r.status >= 500)

if (error) {
  const details = get_network_request(error.id)
  console.log("Server error response:", details.responseBody)
}
```

### Issue: Timeout (No Response)

```javascript
// Look for requests with status 0 or very long time
const requests = list_network_requests()
const timeout = requests.find(r => r.status === 0 || r.time > 60000)

if (timeout) {
  console.log("Request timed out:", timeout.url)
}
```

### Issue: Slow Response

```javascript
// Find requests taking > 5 seconds
const requests = list_network_requests()
const slow = requests.filter(r => r.time > 5000)

if (slow.length > 0) {
  console.log("Slow requests:")
  slow.forEach(r => console.log(`${r.url}: ${r.time}ms`))
}
```

## Best Practices

1. **Check status codes first**: Status >= 400 indicates problems
2. **Verify authentication**: Ensure proper auth headers are sent
3. **Check content types**: Verify response format matches expected
4. **Monitor timing**: Slow responses may need server optimization or caching
5. **Watch request size**: Large payloads may need compression or pagination
6. **Verify request order**: Sequential vs parallel execution affects performance
7. **Check CORS headers**: Required for cross-origin requests
8. **Validate response structure**: Ensure API returns expected data format

## Combining with Other Tools

Network debugging is often combined with:
- **Performance tools**: Check network impact on page performance
- **Console debugging**: Check for JavaScript errors related to network calls
- **DOM inspection**: Verify network data is being rendered
- **Script evaluation**: Check application state after API calls
