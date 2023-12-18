#FINAL PROJECT
#Lu Xuan
#Ruohan Hong

#query 1
#Which companies have more than one license?
USE nj_business_licenses;

SELECT business_name, COUNT(license_nbr) AS license_count
FROM businesses AS b
INNER JOIN licenses AS l
	ON b.business_id = l. business_id
GROUP BY business_name
HAVING license_count >= 1;

#Based on the results, Credit Bureau of Napa County has 2 licenses. 


#Query 2
#To look at the average days between license creation date and 
#license expiration date by license number and 
#compare the valid day of each license to the mean within each license type.
#Saved as temporary table for further analysis.
DROP TABLE IF EXISTS avg_license_days;
CREATE TEMPORARY TABLE avg_license_days AS
SELECT l.license_nbr, t.license_type, 
	DATEDIFF(l.license_expir_date, l.license_creation_date) AS license_diff,
	AVG(DATEDIFF(l.license_expir_date, l.license_creation_date))
	OVER(PARTITION BY t.license_type) AS avg_date_diff
FROM licenses AS l
INNER JOIN license_types AS t
	ON l.license_type_id=t.license_type_id;

SELECT license_nbr, license_type, license_diff, avg_date_diff,
 CASE 
    WHEN license_diff < avg_date_diff THEN "shorter"
    WHEN license_diff = avg_date_diff THEN "average"
    WHEN license_diff > avg_date_diff THEN "longer"
ELSE "N/A"
END AS valid_days_compare_to_mean
FROM avg_license_days;

#license_nbr | license_type | license_diff | avg_date_diff | valid_days_compare_to_the_mean
/*'2048045-DCA','Banking','361','375.0000','shorter'
'2048569-DCA','Banking','389','375.0000','longer'
'2047820-DCA','Business','323','323.0000','average'
'2050340-DCA','Food','418','418.0000','average'
'2047000-DCA','Individual','414','554.2500','shorter'
'2048242-DCA','Individual','422','554.2500','shorter'
'2049090-DCA','Individual','406','554.2500','shorter'
'2050601-DCA','Individual','975','554.2500','longer'
'2048577-DCA','Sales','717','521.0000','longer'
'2048737-DCA','Sales','783','521.0000','longer'
'2049425-DCA','Sales','396','521.0000','shorter'
'2050400-DCA','Sales','255','521.0000','shorter'
'2050645-DCA','Sales','454','521.0000','shorter'
'2050423-DCA','Tour','432','432.0000','average'
'2047741-DCA','Transit','451','451.0000','average'*/



#query 3
#which license type has the most license counts?
SELECT COUNT(l.license_nbr) AS license_count, t.license_type,
RANK()
OVER(ORDER BY COUNT(l.license_nbr) DESC) AS rank_license_count
FROM licenses AS l
LEFT JOIN license_types AS t
	ON l.license_type_id = t.license_type_id
GROUP BY t.license_type;

#Based on the result, the license type "Sales" have the most license counts of 5.



#query 4
# Identify Businesses with Active Licenses in the Most Employed Industry
WITH ranked_industries AS (
    SELECT b.industry_id, 
           SUM(b.num_employee) AS total_employee, 
           i.industry,
           RANK() OVER (ORDER BY SUM(b.num_employee) DESC) AS rank_employee
    FROM businesses AS b 
    INNER JOIN industries AS i
        ON b.industry_id = i.industry_id
    GROUP BY b.industry_id
),
most_employed_industry AS (
    SELECT industry_id, total_employee, industry
    FROM ranked_industries
    WHERE rank_employee = 1
)

SELECT b.business_id, b.business_name,
       l.license_status, m.total_employee, m.industry
FROM businesses AS b
INNER JOIN licenses AS li
    ON b.business_id = li.business_id
INNER JOIN license_statuses AS l
    ON li.license_status_id = l.license_status_id
INNER JOIN most_employed_industry AS m
    ON b.industry_id = m.industry_id
WHERE l.license_status = 'active'
GROUP BY b.business_id, b.business_name, l.license_status;

# IN the most employed industry - Pedicab Business, 
# Based on the result, BENDAHAME, DRISS with business_id of 1003 have the license status of active,
# and toatal emoloyee of 160.





