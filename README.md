# geocoding
Created and maintained by Stuart Craig.

This repository contains a suite of geocoding datasets and tools. 

Did you learn something about the data that ought to be incorporated? Email me at [EMAIL].

## zip2county

The zip2county crosswalk is derived from the HUD data [LINK], which is provided quarterly from 2010Q1 and currently available through 2019Q4. 

### Processing

There is not a clean many-to-1 mapping between zip codes and counties. For each zip code, the HUD reports the share of addresses within each zip code that exist in each county. Our processing procedure selects the county for each zip code that has the most residential addresses. In the event of a tie, we prioritize business addresses, followed by "other" addresses. 

Our final file `GC_zip2county_allQ.dta` contains quarterly observations for each zip code, where the `county` variable reports the 5-digit FIPS code of the county selected using the above procedure.

### Things to watch out for

- **Incomplete zip panels:**
<img src="output/zip2county/GC_zip2county_panelbalance.png" width="75%" height=75% align="middle">

- **Zip codes assigned to multiple counties:** 
<img src="output/zip2county/GC_zip2county_multicounty2.png" width="75%" height=75% align="middle">

## Update log

- A placeholder section

## Known issues (to-do)

- Add
	- State key -- fips, census, name, abbrev, aha code
	- county2cz
	- zip2cz
	- zip2latlon (multiple versions?)
	- Atlas: HRR/HSA
	- HEALTH Service Areas (SEER/CDC)
	- Congressional districts
- County boundary harmonization
- Distance matrices!

