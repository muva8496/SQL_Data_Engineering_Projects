# Exploratory Data Analysis w/ SQL: Job Market Analysis

![Project 1 Overview](../Images/1_1_Project1_EDA.png))

A SQL project analyzing the data engineer job market using real world world job posting data.It  demonstaretes my ability to   **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights.

## Executive Summary

- **Project Scope:** Built **3 analytical queries** that answer key questions about the data engineer job market
- **Data modelling:** Used **multi-table joins** acrosss fact and dimension tables to extraact insights
- **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value
-** Outcomes:** Delivered **actionable insights on SQL/Python dominance, cloud trends, and salary patterns

If you only have a minute , review these:

[Top Demanded Skills Query](01_top_demanded_skills.sql) : demand analysis with multi-table joins

[Top Paying Skills Query](1_EDA/02_highest_paying_skills.sql) :salary analysis with aggregations

[optimalskils](1_EDA/03_optimal_skils.sql): combined demand/salary optimization query

## Problem & Context

Job market analysis need to answer questions like:

- **Most in-demand:** *Which skills are the mostin-demand for data engineer?*
-**Highest paid:** *Which skilss command the highest salaries?*
-**Best trade-offs:** *What is the optimal skill set balancing demand and compensation?*

This project analyzes a **data  warehouse** built using a start schema design.The warehouse structure consists of :

![Data Warehouse](../Images/1_2_Data_Warehouse.png)

- **Fact Tables:** `job_postings_fact` -Central table containing job postings details(job titles, locations, salaries, dates,etc)
- **Dimension Tables:**
    -`company_dim` - Company information linked to job postings
    -`skills_dim` - skill catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship btn job postings and skills

By  querying across these interconnected tables, I extracted insights about skill demand, salary patterns , and optimal skill combinations for data engineering roles.

## Tech Stack

- **Query Engine** DuckDB for fast OLAP-style analytical queries
- **Language:** SQL(ANSI-style with analytical functions)
- **Data Model:** Star Schema with fact+ dimension + bridge tables
- **Development:** VS code for SQL editing + Terminal for  DUckDB for CLI
- **Version Control:** Git/Githiub for versional SQL scripts

## Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)**Identifies the top 10 in-demand skills for remote data engineer positions
2. **[Top Paying Skills](./02_highest_paying_skills.sql)** -Analyzes the 25 highest_paying skills with salary and demand metrics
3.**[Optimal Skills](03_optimal_skils.sql) Calculates an optimal score using natural log of demand  combined with median salary to identify the most valuable skills to learn.

### Key Insights

- Core Languages: SQL and Python each appear in 29,000 job postings,making them the most demanded skills.
- Cloud Platforms; AWS and Azure are critical  for modern data engineering roles.
-Infra & Tooling : Kubernetes,Docker,and Terraform are associated with premium salaries.
- Big  data tools: Apache Spark shows strong demand with competitive compensation.

## SQL Skills Demonstrated

### Query Design & optimization

 - **Complex Join**: Multi-table `INNER JOIN` operations across `job_postings_fact` , `skills_job_dim`,and `skills_dim`

 - **Aggregations**: `COUNT()`, `MEDIAN()`, `ROUND()`,for statistical analysis

 - **Filterings**: Boolean logic with `WHERE` clauses and multiple conditions
 (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
 -**Sorting & Limitings**: 'ORDER BY' with 'DESC' and 'LIMIT for top-N analysis

 ### Analysis Techniques

- **Groupings** : `GROUP BY` for categorical analysis by skill
 - **Conditional Logic** :`CASE WHEN` statements for derived metrics
 - **Mathematical Functions**: `IN()` for natural log transformation to normalize demand metrics.
 - **Calculated Metrics**: Derived optimal scores combining log-transformed demand with median_slary
 - HAVING CLAUSES**: Filtering aggregated results(skills with >= 100 postings) 
 - **NULL HANDLINGS** Proper filtering of incomplete records(`salary_year_avg` IS NOT NULL)





```sql
select
    sd.skills,
    COUNT(jpf.*) AS demand_count
from job_postings_fact AS jpf
inner join skills_job_dim as sjd
    on jpf.job_id = sjd.job_id
inner join skills_dim as sd
on sjd.skill_id =sd.skill_id
where  jpf.job_title_short ='Data Engineer'
        and jpf.job_work_from_home = true 
group by sd.skills
order by demand_count desc
limit 10;

```



