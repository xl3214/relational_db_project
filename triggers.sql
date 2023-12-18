USE nj_business_licenses;

# 1. In businesses table
DELIMITER //
CREATE TRIGGER trigger_business
	BEFORE INSERT ON businesses
	FOR EACH ROW
BEGIN
    -- 1) Ensures number of employee entered is positive
	IF NEW.num_employee < 0 THEN
		SIGNAL SQLSTATE "HY000" 
		SET MESSAGE_TEXT = "Error: Number of employee cannot be negative";
    END IF;
    -- 2) Ensures business zip codes entered are of length 5 
    IF LENGTH(NEW.zipcode) <> 5 THEN
		SIGNAL SQLSTATE "HY000" 
		SET MESSAGE_TEXT = "Error: Business zip code must be 5 digits in length";
	END IF;
END;//
DELIMITER ;

# 2. In licenses table
DELIMITER //
CREATE TRIGGER trigger_license
	BEFORE INSERT ON licenses
	FOR EACH ROW
BEGIN
	-- 1) Ensures the cost of licenses are not negative
    IF NEW.license_cost < 0 THEN
		SIGNAL SQLSTATE "HY000" 
		SET MESSAGE_TEXT = "Error: Cost of license cannot be negative";
    END IF;
    -- 2) Ensures license date validity: expiration date cannot be earlier than creation date
    IF DATEDIFF(NEW.license_creation_date, license_expir_date) < 0 THEN
		SIGNAL SQLSTATE "HY000" 
		SET MESSAGE_TEXT = "Error: License expiration date cannot be before license creation date";
    END IF;
END;//
DELIMITER ;