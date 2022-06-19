
/*
Cleaning Data in SQL Queries

*/


Select *
From DAPortfolioProject...NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- 1. STANDARDIZE DATE FORMAT

--convert saleDate to Standardize date format and save in SaleDateConverted
Select saleDateConverted, CONVERT(Date,SaleDate)
From DAPortfolioProject..NashvilleHousing


Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

-- 2.POPULAT PROPERTY ADDRESS

Select *
From DAPortfolioProject..NashvilleHousing
--Where PropertyAddress is null
order by ParcelID

-- The query below Join a Table to itself and select ParcelID's which had NULL P.Address on first table and P.Address on second table
--- such that UniqueID isnot same.

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From DAPortfolioProject..NashvilleHousing a
JOIN DAPortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

--UPdating the NULL P.Address from the second table wih P.Address first table 
Update a 
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From DAPortfolioProject..NashvilleHousing a
JOIN DAPortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------

-- 3.BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (Address, City, State)


Select PropertyAddress
From DAPortfolioProject..NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID


--Breaking with the Substring function.
-- Break from the first position(,) and goback once(-1) as address
-- Break from CHARINDEDX(,) and gofront(+1) return the full lenght as state. 
SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as City

From DAPortfolioProject..NashvilleHousing

-- Alter Table save split address and state with new new column headers

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))



-- select to preview updated column
Select *
From DAPortfolioProject..NashvilleHousing





Select OwnerAddress
From DAPortfolioProject..NashvilleHousing

---Breaking the OwnerAddress using the PARSENAME Function 
--(The function Replaces the delimeter(,) with period(.) and breaks in reverse manner .. reasons why the position are reverse)

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From DAPortfolioProject..NashvilleHousing


--Store the splitted address,city and state in new columns
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


--Preview New Column
Select *
From DAPortfolioProject..NashvilleHousing



-- 4. REPLACE "N" AND "Y" TO "NO" AND "YES" IN "SoldAsVacant" Column

--select to preview N and Y count.

SELECT	DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM DAPortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2


--- Replacement selection
Select SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END
From DAPortfolioProject..NashvilleHousing


--- UPdating the columns
UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
		WHEN SoldAsVacant = 'N' THEN 'NO'
		ELSE SoldAsVacant
		END


--- 5.REMOVING DUPLICATE 


SELECT * 

From DAPortfolioProject..NashvilleHousing