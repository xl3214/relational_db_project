SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS nj_business_licenses;
CREATE SCHEMA nj_business_licenses;
USE nj_business_licenses;

/* Create Tables */
-- Parent Table: businesses
DROP TABLE IF EXISTS businesses;
CREATE TABLE businesses (
  business_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  business_name VARCHAR(255) NOT NULL,
  business_profitable_income INT UNSIGNED DEFAULT 0, 
  num_employee INT UNSIGNED DEFAULT 0,
  building VARCHAR(255) DEFAULT NULL, 
  street VARCHAR(255) DEFAULT NULL,
  city VARCHAR(255) DEFAULT NULL, 
  zipcode VARCHAR(5) DEFAULT NULL, 
  phone VARCHAR(11) DEFAULT NULL, 
  industry_id TINYINT UNSIGNED DEFAULT NULL, 
  PRIMARY KEY (business_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Child Table: licenses
DROP TABLE IF EXISTS licenses;
CREATE TABLE licenses (
  license_nbr VARCHAR(255) NOT NULL,
  business_id INT UNSIGNED NOT NULL,
  license_creation_date DATE,
  license_expir_date DATE,
  license_cost INT UNSIGNED DEFAULT 0,
  license_status_id TINYINT UNSIGNED DEFAULT NULL,
  license_type_id TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY  (license_nbr)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Lookup Table: license_types
DROP TABLE IF EXISTS license_types;
CREATE TABLE license_types (
  license_type_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  license_type VARCHAR(255) NOT NULL,
  PRIMARY KEY  (license_type_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Lookup Table: license_statuses
DROP TABLE IF EXISTS license_statuses;
CREATE TABLE license_statuses (
  license_status_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  license_status VARCHAR(255) NOT NULL,
  PRIMARY KEY  (license_status_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Lookup Table: industries
DROP TABLE IF EXISTS industries;
CREATE TABLE industries (
  industry_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  industry VARCHAR(255) NOT NULL,
  PRIMARY KEY  (industry_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;