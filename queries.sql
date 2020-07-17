-- 1) non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT 
c.FirstName,
c.LastName,
c.CustomerId,
c.Country
FROM Customer c
WHERE c.Country != "USA";

-- 2) brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT * FROM Customer c
WHERE c.Country = "Brazil";

-- 3) brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT
c.FirstName,
c.LastName,
i.InvoiceId,
i.InvoiceDate,
i.BillingCountry
FROM Invoice i
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
WHERE c.Country = "Brazil";

-- 4) sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT * FROM Employee e
WHERE e.Title = "Sales Support Agent";

-- 5) unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT i.BillingCountry
FROM Invoice i
ORDER BY i.BillingCountry ASC;

-- 6) sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT
e.FirstName AS 'SalesAgentFirstName',
e.LastName AS 'SalesAgentLastName',
i.*
FROM Customer c
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId;

-- 7) invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT
c.FirstName AS 'CustomerFirstName',
c.LastName AS 'CustomerLastName',
c.Country,
e.FirstName AS 'SalesAgentFirstName',
e.LastName AS 'SalesAgentLastName',
i.Total
FROM Customer c
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId;

-- 8) total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

SELECT
STRFTIME('%Y', i.InvoiceDate) AS 'Year',
COUNT(i.InvoiceId) AS 'NumberOfInvoices'
FROM Invoice i 
WHERE Year = '2009'
OR Year = '2011'
GROUP BY Year;

-- 9) total_sales_{year}.sql: What are the respective total sales for each of those years?

SELECT
STRFTIME('%Y', i.InvoiceDate) AS 'Year',
SUM(i.Total) AS 'TotalSales'
FROM Invoice i 
WHERE Year = '2009'
OR Year = '2011'
GROUP BY Year;

-- 10) invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT
COUNT(i.InvoiceId) AS 'Invoice37Count'
FROM InvoiceLine i
WHERE i.InvoiceId = 37;

-- 11) line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT
il.InvoiceId,
COUNT(il.InvoiceId) AS 'NumberOfInvoiceLines'
FROM InvoiceLine il 
GROUP BY il.InvoiceId;

-- 12) line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT
t.Name AS 'TrackName',
i.*
FROM InvoiceLine i
LEFT JOIN Track t ON i.TrackId = t.TrackId;

-- 13) line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT
t.Name AS 'TrackName',
ar."Name" AS 'ArtistName',
i.*
FROM InvoiceLine i
LEFT JOIN Track t ON i.TrackId = t.TrackId
LEFT JOIN Album al ON t.AlbumId = al.AlbumId
LEFT JOIN Artist ar ON al.ArtistId = ar.ArtistId;

-- 14) country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT
DISTINCT COUNT(i.BillingCountry) AS 'NumberOfInvoices'
FROM Invoice i 
GROUP BY i.BillingCountry;

-- 15) playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

SELECT
p.Name AS 'PlaylistName',
COUNT(pt.TrackId) AS 'NumberOfTracks'
FROM PlaylistTrack pt
LEFT JOIN Playlist p ON pt.PlaylistId = p.PlaylistId
GROUP BY pt.PlaylistId;

-- 16) tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT
t.Name AS 'TrackName',
a.Title AS 'AlbumTitle',
m.Name AS 'MediaTypeName',
g.Name AS 'GenreName',
t.Composer,
t.Milliseconds,
t.Bytes,
t.UnitPrice
FROM Track t
LEFT JOIN Album a ON t.AlbumId = a.AlbumId
LEFT JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId
LEFT JOIN Genre g ON t.GenreId = g.GenreId;

-- 17) invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT
i.*,
COUNT(i.InvoiceId) AS 'NumberOfLineItems'
FROM Invoice i
LEFT JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId;

-- 18) sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

SELECT
e.EmployeeId,
e.FirstName,
e.LastName,
SUM(i.Total) as 'Total Sales'
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE e.Title = 'Sales Support Agent'
GROUP BY e.EmployeeId;

-- 19. top_2009_agent.sql: Which sales agent made the most in sales in 2009?
SELECT sub.agent AS "Sales Agent", MAX(sub.top) AS "Top 2009 Sales"
FROM
(SELECT e.FirstName || " " || e.LastName AS agent, SUM(i.Total) AS top 
		FROM Employee e
		JOIN Customer c ON e.EmployeeId = c.SupportRepId
		JOIN Invoice i ON c.CustomerId = i.CustomerId
		AND i.InvoiceDate BETWEEN "2009-01-01" AND "2009-12-31"
		GROUP BY e.EmployeeId) sub;

-- 20. top_agent.sql: Which sales agent made the most in sales over all?
SELECT sub.agent AS "Sales Agent", MAX(sub.top) AS "Top 2009 Sales"
FROM
(SELECT e.FirstName || " " || e.LastName AS agent, printf("%.2f", SUM(i.Total)) AS top 
		FROM Employee e
		JOIN Customer c ON e.EmployeeId = c.SupportRepId
		JOIN Invoice i ON c.CustomerId = i.CustomerId
		GROUP BY e.EmployeeId) sub;

-- 21) sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

SELECT
e.EmployeeId,
e.FirstName,
e.LastName,
COUNT(c.SupportRepId) AS 'NumberOfCustomers'
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
WHERE e.Title = "Sales Support Agent"
GROUP BY e.EmployeeId;

-- 22) sales_per_country.sql: Provide a query that shows the total sales per country.

SELECT
DISTINCT i.BillingCountry,
SUM(i.Total) AS 'TotalSales'
FROM Invoice i
GROUP BY i.BillingCountry;

-- 23. top_country.sql: Which country's customers spent the most?
SELECT sub.country AS "Country", MAX(sub.total) AS "Sales"
FROM 
	(SELECT i.BillingCountry AS country, SUM(i.Total) AS total
	FROM Invoice i
	GROUP BY i.BillingCountry) sub;

SELECT i.BillingCountry AS country, SUM(i.Total) AS total
	FROM Invoice i
	GROUP BY i.BillingCountry
	ORDER BY total DESC
	LIMIT 1;

-- 24. top_2013_track.sql: Provide a query that shows the most purchased track of 2013.
SELECT x.Song AS "Song" , MAX(x.Num) AS "Times Purchased"
FROM 
	(SELECT t.Name AS Song, SUM(il.Quantity) AS Num, i.InvoiceDate
		FROM Invoice i
		JOIN InvoiceLine il ON il.InvoiceId = i.InvoiceId
		JOIN Track t ON il.TrackId = t.TrackId
		WHERE i.InvoiceDate BETWEEN "2013-01-01" AND "2013-12-31"
		GROUP BY t.Name) x;

-- 25. top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.
SELECT t.Name AS "Song", SUM(il.Quantity) AS "Times Purchased"
	FROM  InvoiceLine il
	JOIN Track t ON il.TrackId = t.TrackId
	GROUP BY t.Name
	ORDER BY "Times Purchased" DESC
	LIMIT 5;

-- 26. top_3_artists.sql: Provide a query that shows the top 3 best selling artists.
SELECT a.Name, SUM(il.Quantity) AS "Tracks Sold"
FROM Artist a
JOIN Album b ON b.ArtistId = a.ArtistId
JOIN Track t ON t.AlbumId = b.AlbumId
JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY a.Name
ORDER BY "Tracks Sold" DESC
LIMIT 3;

-- 27. top_media_type.sql: Provide a query that shows the most purchased Media Type.
SELECT x.media AS "Media Type", MAX(x.num) AS "Amount of Media Sold"
	FROM 
		(SELECT m.Name AS media, SUM(il.Quantity) AS num
		FROM MediaType m
		JOIN Track t ON t.MediaTypeId = m.MediaTypeId
		JOIN InvoiceLine il ON t.TrackId = il.TrackId
		GROUP BY m.Name
		) x;