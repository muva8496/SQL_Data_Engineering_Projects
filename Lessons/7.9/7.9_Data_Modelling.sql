select 
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
from 
    job_postings_fact
limit 10;

Select
    company_id,
    name
from
    company_dim
limit 10;

select *
from company_dim
where 
    name IN ('Facebook','Meta')
limit 5;

select *
from skills_job_dim
limit 5;

select *
from skills_dim
limit 5;

select *
from information_schema.tables
where table_catalog = 'data_jobs';

select *
from information_schema.columns
where table_catalog = 'data_jobs';

PRAGMA show_tables;

PRAGMA show_tables_expanded;

DESCRIBE job_postings_fact;

