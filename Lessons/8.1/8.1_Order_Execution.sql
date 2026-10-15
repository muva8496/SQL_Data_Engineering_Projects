/*
Find the top 10 companies for posting joba
They must have  >3000 postings
Limit this tro only US jobs
*/

select
    cd.name as company_name,
    COUNT(jpf.job_id) as total_postings
from job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    on jpf.company_id = cd.company_id
where jpf.job_country = 'United States'
group by cd.name
having count(jpf.job_id) > 3000
order by total_postings desc;

EXPLAIN
select
    cd.name as company_name,
    COUNT(jpf.job_id) as total_postings
from job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    on jpf.company_id = cd.company_id
where jpf.job_country = 'United States'
group by cd.name
having count(jpf.job_id) > 3000
order by total_postings desc;

EXPLAIN ANALYZE
select
    cd.name as company_name,
    COUNT(jpf.job_id) as total_postings
from job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    on jpf.company_id = cd.company_id
where jpf.job_country = 'United States'
group by cd.name
having count(jpf.job_id) > 3000
order by total_postings desc;