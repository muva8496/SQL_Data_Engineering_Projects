select 
    jpf.*,
    cd.*
from
    job_postings_fact AS jpf
LEFT JOIN
    company_dim AS cd
    ON jpf.company_id = cd.company_id
LIMIT 10;
/* left join*/

 select 
            jpf.job_id,
                jpf.job_title_short,
                cd.company_id,
                cd.name as company_name,
                jpf.job_location
from
                job_postings_fact AS jpf
            LEFT JOIN
                company_dim AS cd
                ON jpf.company_id = cd.company_id
LIMIT 10;

/*right join*/

/* inner join*/

 select 
            jpf.job_id,
                jpf.job_title_short,
                cd.company_id,
                cd.name as company_name,
                jpf.job_location
from
                job_postings_fact AS jpf
            INNER JOIN
                company_dim AS cd
                ON jpf.company_id = cd.company_id
LIMIT 10;

/* full outer join*/

 select 
            jpf.job_id,
                jpf.job_title_short,
                cd.company_id,
                cd.name as company_name,
                jpf.job_location
from
                job_postings_fact AS jpf
            FULL OUTER JOIN
                company_dim AS cd
                ON jpf.company_id = cd.company_id
LIMIT 10;

select *
from skills_job_dim
limit 5;

select *
from skills_dim
limit 10;

SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills,
FROM job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
limit 100;


SELECT
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills,
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
LIMIT 100;