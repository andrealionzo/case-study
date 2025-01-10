# Case Study: Analyzing Airbnb Listings in Berlin using SQL
## Introduction
In this case study, I explore the Airbnb listings in Berlin as of July 2021 using SQL to understand various aspects of the short-term rental market and its patterns. The dataset includes detailed information on Airbnb listings across the city.

The analysis aims to uncover patterns and insights around the following key questions:

- How many full apartments are available year-round or for more than six months?
- How many rooms are rented out by hosts who own one vs. more than one listing?
- How does owning multiple rooms or apartments affect the rental price?
- In which areas is the price difference of owners with one vs. multiple apartments higher across Berlin?
- How do East and West Berlin compare in terms of prices, room types, and hosts?

The analysis is conducted using MySQL, where I query and manipulate the data to uncover trends and insights. Additionally, I provide visualizations created using Tableau to complement the analysis and help better interpret the findings.

## Dataset Overview
The dataset used in this case study comes from [this Kaggle dataset](https://www.kaggle.com/datasets/lennarthaupts/airbnb-berlin-july-2021/data). It contains a variety of details about Airbnb listings in Berlin, including:

- Listing IDs
- Host information
- Room types (entire home, private room, shared room)
- Price per night
- Location
- Availability during the year

You can download the dataset and the SQL script used for analysis from the links provided below:

[Download the Dataset](https://github.com/andrealionzo/case-study/blob/main/listings_berlin1.csv)

[Check or Download the SQL Script](https://github.com/andrealionzo/case-study/blob/main/case-study-berlin-airbnb.sql)

## Approach
To explore and analyze the data, I wrote several SQL queries to explore and clean the data, and then to gather the necessary data to address each of the questions above.

## Key Insights & Results
Some of the key findings from the analysis include:

- Apartment availability: The number of full apartments available for more than 6 months was lower (about 1/3) than the total number of full apartments, indicating a strong market for full apartments on Airbnb. The same applied to private rooms.
- Multi-listing hosts: Hosts who own multiple listings tend to charge lower prices for their properties. This could be due to economies of scale (owning several apartments/rooms reduces their cost per unit), and competitive pricing strategies for the need for higher occupancy rates across their listings.
- Geographical differences: There were noticeable differences in pricing between East and West Berlin, with East Berlin exhibiting higher prices (74 euros vs. 61 euros for West Berlin). Additionally, the number of properties listed on Airbnb for East Berlin is higher than the one for West Berlin (1480 vs. 744). This shows an interesting and potentially unexpected finding that could be worth further analysis.

## Visualizations
To enhance the understanding of the data and insights, I created a series of interactive visualizations in Tableau Public. These visualizations highlight:

- Distribution of prices across different neighborhoods.
- Price trends for hosts owning one versus multiple listings.
- Availability of listings for more or less than six months per year.

You can explore these visualizations here:

[View Visualizations on Tableau Public](https://public.tableau.com/views/BerlinAirbnbCaseStudy_17365354378540/BerlinAirBnbListingsbyDistrict?:language=en-GB&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Conclusion
This case study highlights how Airbnb listings in Berlin are distributed across the city and their patterns in terms of prices, property distribution by area, room types, and hosts. The insights gathered from this analysis provide a better understanding of the short-term rental market in Berlin, especially in the context of rising rental prices and property availability.
