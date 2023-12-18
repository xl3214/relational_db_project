-- Setting Foreign Key Constraints after Data Import is finished.
ALTER TABLE licenses
ADD FOREIGN KEY (business_id) REFERENCES businesses (business_id) 
	ON DELETE RESTRICT 
	ON UPDATE CASCADE,
ADD FOREIGN KEY (license_type_id) REFERENCES license_types (license_type_id) 
	ON DELETE RESTRICT 
	ON UPDATE CASCADE,
ADD FOREIGN KEY (license_status_id) REFERENCES license_statuses (license_status_id) 
	ON DELETE RESTRICT 
	ON UPDATE CASCADE;
    
ALTER TABLE businesses
ADD FOREIGN KEY (industry_id) REFERENCES industries (industry_id) 
	ON DELETE RESTRICT 
	ON UPDATE CASCADE;