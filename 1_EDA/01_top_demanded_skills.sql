/*
Identify top 10 in-demand skills for data engineers.
Focus on remote job postings
Why?Retrieves the top 10 skills with the highest demand for data engineers in remote job postings. This information can help job seekers and professionals understand the skills that are currently most sought after in the field of data engineering, allowing them to tailor their learning and development efforts accordingly.
*/

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

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
*/



