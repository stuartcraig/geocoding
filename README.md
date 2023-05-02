# geocoding

A suite of geocoding datasets and tools. Maintained by Stuart Craig. Did you learn something about the data that ought to be incorporated? Email me at [EMAIL].

## zip2county

The zip2county crosswalk is derived from the HUD data [LINK], which is provided quarterly from 2010Q1 and currently available through 2019Q4. 

### Processing
There is not a clean many-to-1 mapping between zip codes and counties. For each zip code, the HUD reports the share of addresses within each zip code that exist in each county. Our processing procedure selects the county for each zip code that has the most residential addresses. In the event of a tie, we prioritize business addresses, followed by "other" addresses. 

### Things to watch out for:
- *Incomplete zip panels:* 
- *Zip codes assigned to multiple counties:* 

## Update log

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

