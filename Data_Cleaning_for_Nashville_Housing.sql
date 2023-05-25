/*

Nashville Housing Data Cleaning

*/

USE Nashville ;
Select * From NashvilleHousing ;

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format --

--Change Sale Date Format
-- Add a new column 'SaleDateConverted' to store the converted SaleDate
ALTER TABLE NashvilleHousing
ADD SaleDateConverted DATE;

-- Update the 'SaleDateConverted' column with converted SaleDate values
UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE, SaleDate);

 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data --

-- Update PropertyAddress with non-null values from matching records
UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing AS a
JOIN NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL;

-- Checking if the previous query was successful
SELECT PropertyAddress
FROM NashvilleHousing
WHERE PropertyAddress IS NULL;

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State) --

-- Breaking out Property Address
-- Add new columns 'PropertySplitAddress' and 'PropertySplitCity' to store separated values
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255),
    PropertySplitCity NVARCHAR(255);

-- Update 'PropertySplitAddress' column with the substring before the comma
UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1);

-- Update 'PropertySplitCity' column with the substring after the comma
UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress));

-- Breaking out Owner Address
-- Add new columns 'OwnerSplitAddress', 'OwnerSplitCity', and 'OwnerSplitState' to store separated values
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255),
    OwnerSplitCity NVARCHAR(255),
    OwnerSplitState NVARCHAR(255);

-- Update 'OwnerSplitAddress' column with the parsed third part of OwnerAddress
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

-- Update 'OwnerSplitCity' column with the parsed second part of OwnerAddress
UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

-- Update 'OwnerSplitState' column with the parsed first part of OwnerAddress
UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);

--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field --

-- Update 'SoldAsVacant' column values to 'Yes' if 'Y', 'No' if 'N', or keep the original value
UPDATE NashvilleHousing
SET SoldAsVacant = CASE
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates --

-- Delete duplicate records based on the specified criteria
WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
                         PropertyAddress,
                         SaleDate,
                         SalePrice,
                         LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1;

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns --

-- Remove columns 'SaleDate', 'PropertyAddress', and 'OwnerAddress'
ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate,
              PropertyAddress,
              OwnerAddress;

-----------------------------------------------------------------------------------------------------------

-- Final query to retrieve the modified data
SELECT *
FROM NashvilleHousing;