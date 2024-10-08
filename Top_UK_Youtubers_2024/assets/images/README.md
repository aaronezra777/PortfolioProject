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

This is the stage where you have a scan of what’s in the data, errors, inconcsistencies, bugs, weird and corrupted characters etc<br/>

What are your initial observations with this dataset? What’s caught your attention so far?<br/>

-There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data.<br/>
-The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol - we need to extract the channel names from this.<br/>
-Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.<br/>
-We have more data than we need, so some of these columns would need to be removed<br/>

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/overalldata.JPG)

**Data cleaning & transformation**<br/>
<br/>
What steps are needed to clean and shape the data into the desired format?<br/>
<br/>
1) Remove unnecessary columns by only selecting the ones you need<br/>
2) Extract Youtube channel names from the first column<br/>
3) Rename columns using aliases
<br/>

![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/datacleaningsql.JPG)

**Dashboard Overview**<br/>
The cleaned and transformed data are loaded into Power BI and the following virtually engaging and interactive dashboard are created.
<br/>
![image](https://github.com/aaronezra777/PortfolioProject/blob/main/Top_UK_Youtubers_2024/assets/images/PowerBIDB_UK_Utubers.png)


