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
COUNT(i.InvoiceDate) AS 'NumberOfInvoices'
FROM Invoice i 
WHERE i.InvoiceDate LIKE '2009%'
OR i.InvoiceDate LIKE '2011%';

-- 9) total_sales_{year}.sql: What are the respective total sales for each of those years?

-- 10) invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT
COUNT(i.InvoiceId) as 'Invoice37Count'
FROM InvoiceLine i
WHERE i.InvoiceId = 37;

-- 11) line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

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

-- 16) tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

-- 17) invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

-- 18) sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

-- 19) top_2009_agent.sql: Which sales agent made the most in sales in 2009?

-- Hint: Use the MAX function on a subquery.

-- 20) top_agent.sql: Which sales agent made the most in sales over all?

-- 21) sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

-- 22) sales_per_country.sql: Provide a query that shows the total sales per country.

-- 23) top_country.sql: Which country's customers spent the most?

-- 24) top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

-- 25) top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.

-- 26) top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

-- 27) top_media_type.sql: Provide a query that shows the most purchased Media Type.