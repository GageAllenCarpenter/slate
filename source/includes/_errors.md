# Errors

The EDI API uses the following error codes:


Error Code | Meaning
---------- | -------
400 | Bad Request -- Your request is invalid.
401 | Unauthorized -- Your API key is wrong.
403 | Forbidden -- The value requested is hidden for administrators only.
404 | Not Found -- The specified value could not be found.
405 | Method Not Allowed -- You tried to access a value with an invalid method.
406 | Not Acceptable -- You requested an unsupported format.
410 | Gone -- The value requested has been removed from our servers.
429 | Too Many Requests -- You're requesting too much! Slow down!
500 | Internal Server Error -- We had a problem with our server. Try again later.
503 | Service Unavailable -- We're temporarily offline for maintenance. Please try again later.
