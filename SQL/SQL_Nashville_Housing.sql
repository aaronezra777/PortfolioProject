--Cleaning data in sql queries

select *
from PortfolioProject..NashvilleHousingdata

--Standardize date format

Select SaleDate, Convert(date,SaleDate)
from PortfolioProject.dbo.NashvilleHousingData

Alter table PortfolioProject.dbo.NashvilleHousingData
Add SaleDateConverted Date;

Update PortfolioProject.dbo.NashvilleHousingData
Set SaleDateConverted = Convert(date,SaleDate)

--Populate Property address data

Select *
From PortfolioProject.dbo.NashvilleHousingdata
--Where PropertyAddress is NULL
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousingData a
join PortfolioProject.dbo.NashvilleHousingData b
 on a.ParcelID = b.ParcelID
 AND a.[UniqueID] <> b.[UniqueID]
 where a.PropertyAddress is NULL


Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousingData a
join PortfolioProject.dbo.NashvilleHousingData b
 on a.ParcelID = b.ParcelID
 AND a.[UniqueID] <> b.[UniqueID]
 where a.PropertyAddress is NULL

 -- Break address into individual column (Address, city, state)

select PropertyAddress
from PortfolioProject..NashvilleHousingdata

select
substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) as Address
, substring(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address
from PortfolioProject..NashvilleHousingdata

Alter table PortfolioProject.dbo.NashvilleHousingData
Add PropertySplitAddress nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set PropertySplitAddress = substring(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1)

Alter table PortfolioProject.dbo.NashvilleHousingData
Add PropertySplitCity nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set PropertySplitCity = substring(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

-- Break owner address into individual column (Address, city, state)

select OwnerAddress
from PortfolioProject..NashvilleHousingdata

Select 
PARSENAME(REPLACE(OwnerAddress,',','.'),3)
,PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress,',','.'),1)
from PortfolioProject..NashvilleHousingdata

Alter table PortfolioProject.dbo.NashvilleHousingData
Add OwnerSplitAddress nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

Alter table PortfolioProject.dbo.NashvilleHousingData
Add OwnerSplitTown nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set OwnerSplitTown = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

Alter table PortfolioProject.dbo.NashvilleHousingData
Add OwnerSplitCity nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

--Change Y and N to Yes and No in "sold as vacant" field

Select distinct SoldAsVacant, Count(SoldAsVacant)
from PortfolioProject..NashvilleHousingdata
Group by SoldAsVacant
Order by 2

Select 
SoldAsVacant,
CASE
WHEN SoldAsVacant='Y' THEN 'Yes'
WHEN SoldAsVacant='N' THEN 'No'
WHEN SoldAsVacant='No' THEN 'No'
WHEN SoldAsVacant='Yes' THEN 'Yes'
ELSE '1'
END AS SoldAsVacantCleaned

from PortfolioProject..NashvilleHousingdata

Alter table PortfolioProject.dbo.NashvilleHousingData
Add SoldAsVacantCleaned nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousingData
Set SoldAsVacantCleaned = 

CASE
WHEN SoldAsVacant='Y' THEN 'Yes'
WHEN SoldAsVacant='N' THEN 'No'
WHEN SoldAsVacant='No' THEN 'No'
WHEN SoldAsVacant='Yes' THEN 'Yes'
ELSE SoldAsVacant

END

Update PortfolioProject.dbo.NashvilleHousingData
Set SoldAsVacant = CASE
WHEN SoldAsVacant='Y' THEN 'Yes'
WHEN SoldAsVacant='N' THEN 'No'
ELSE SoldAsVacant

END

--IDENTIFY DUPLICATES

WITH ROWNUMCTE AS(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				LegalReference
				ORDER BY 
					UniqueID
					) row_num
from PortfolioProject..NashvilleHousingdata
)

SELECT*
FROM ROWNUMCTE
WHERE row_num>1
ORDER BY PropertyAddress

SELECT ParcelID, PropertyAddress,LegalReference,
COUNT(*) as duplicate
FROM PortfolioProject..NashvilleHousingdata
GROUP BY ParcelID, PropertyAddress,LegalReference
HAVING COUNT(*) > 1;


-- DELETE UNUSED COLUMN

ALTER TABLE PortfolioProject..NashvilleHousingdata
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


