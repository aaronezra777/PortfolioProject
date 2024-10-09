**Top UK Youtubers 2024**

**Objective** <br/>
<br/>
The Head of Marketing wants to find out who the top YouTubers are in 2024 to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.

To create a dashboard that provides insights into the top UK YouTubers in 2024 that includes their:

-subscriber count<br/>
-total views<br/>
-total videos<br/>
-engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

**Tools**

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/tools.png)


**Data exploration notes**<br/>

This is the stage where I scan of the data for any errors, inconsistencies, bugs, and corrupted characters etc<br/>

Based on the initial observations with this dataset: <br/>

-There are at least 4 columns that contain the data that are needed for this analysis, which signals I have everything I need from the file without needing to contact the client for any more data.<br/>
-The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol -I need to extract the channel names from this.<br/>
-Some of the cells and header names are in a different language -I need to confirm if these columns are needed, and if so, need to address them.<br/>
-I have more data than I need, so some of these columns would need to be removed<br/>

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/overalldata.JPG)

**Data cleaning & transformation**<br/>
<br/>
What steps are needed to clean and shape the data into the desired format?<br/>
<br/>
1) Remove unnecessary columns by only selecting the ones you need<br/>
2) Extract Youtube channel names from the first column<br/>
3) Rename columns using aliases
<br/>
Below are the SQL code used for this data cleaning & transformation<br/>

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/datacleaningsql.JPG)

**Data Quality check**<br/>

Here are the data quality tests conducted:<br/>

Row count check<br/>
Column count check<br/>
Data type check<br/>
Duplicate count check<br/>

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/dataqualitycheck.JPG))
<br/>

**Dashboard Overview**<br/>

The cleaned and transformed data are loaded into Power BI and the following virtually engaging and interactive dashboard are created.
<br/>
![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/PowerBIDB_UK_Utubers.png)

This shows the Top UK Youtubers in 2024 so far.

**DAX Measures**

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/DAXcalculations.JPG)

**Recommendations**<br/>

What are the recommendations based on the insights gathered?<br/>
<br/>
1) NoCopyrightSOunds, Dan Rhodes and DanTDM are the channnels with the most subscribers in the UK.<br/>
2) DanTDM, Dan Rhodes and Mister Max are the channels with the most views.<br/>
3) Based on this analysis, the top channels to form collaborations with are NoCopyrightSounds, DanTDM, Dan Rhodes and Mister Max.<br/>


