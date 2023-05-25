# SQL Data Cleaning for Nashville Housing Dataset
![image](https://github.com/khaledtarek99/SQL-Data-Cleaning-of-Nashville-Housing/assets/53887110/c19b64a1-a565-4d12-b9bc-501fb07881a0)

This project aims to transform and clean the Nashville Housing dataset, ensuring data consistency and improving its usability for further analysis. The dataset contains information related to property sales in Nashville.
# Table of Contents
* Introduction
* Requirements
* Installation
* Usage
* Contributing
* License
# Introduction
The Nashville Housing dataset requires various data transformations and cleaning operations to improve data quality and facilitate analysis. This project provides SQL queries and steps to execute these operations effectively.
<br /> <br />
The key transformations and cleaning tasks performed on the dataset include:
* Changing the sale date format to a standardized format.
* Populating property address data for null values by matching records.
* Breaking out addresses into individual columns (address, city, state) for better analysis.
* Parsing and separating owner addresses into individual address, city, and state columns.
* Updating specific field values to ensure consistency (e.g., changing 'Y' and 'N' to 'Yes' and 'No' in the "Sold as Vacant" field).
* Removing duplicate records based on specific criteria.
* Deleting unused columns from the dataset.
# Requirements
To run this project, you need the following:
* SQL Server or any relational database management system that supports SQL.
* Access to the Nashville Housing dataset.
# Installation
1. Clone this repository to your local machine or download the project as a ZIP file.
2. Import the Nashville Housing dataset into your preferred SQL database.
# Usage
1. Connect to your SQL database using a suitable client or interface.
2. Execute the provided SQL queries in the specified order to perform the necessary transformations and cleaning operations on the Nashville Housing dataset.
3. Review the results and verify the changes made to the dataset.
4. Utilize the modified dataset for further analysis or applications.
<br /><br />Please note that executing the SQL queries requires basic knowledge of SQL and access to the Nashville Housing dataset.
# Contributing
Contributions to this project are welcome. If you encounter any issues or have suggestions for improvement, please feel free to open an issue or submit a pull request.
# License
This project is licensed under the MIT License. Feel free to modify and use the code for personal or commercial purposes.
