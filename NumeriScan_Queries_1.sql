-- shows you the most used Extraction Models and, based on how often they appeared in Jobs
-- and how often

-- Selects columns we want to show
SELECT m.model_id,m.model_name,
       count(j.model_id) AS usage_count
--Joining the Tables together to gain the information we need
FROM extraction_models AS m
JOIN extraction_jobs AS j ON m.model_id = j.model_id
GROUP BY m.model_id,m.model_name
-- sorting the output in descending order
ORDER BY usage_count DESC
-- just show the first column
LIMIT 1;

-- shows u the document with the most extracted values, I crated a View in the Table file
-- to make this process much easier

SELECT d.document_id,d.document_name,
       count(*) as num
FROM document_job_id_extracted_values as d
GROUP by d.document_id, d.document_name
ORDER BY num DESC
LIMIT 1;

-- shows the company that spend the most amount of money to NumeriScan
SELECT o.organisation_id, o.organisation_name,
       oi.month_subscribed,s.monthly_price,
       (oi.month_subscribed * s.monthly_price) AS higest_billed
FROM organisations AS o
JOIN org_account_information AS oi ON o.organisation_id = oi.organisation_id
JOIN subscription AS s ON o.subscription_id = s.subscription_id
ORDER BY higest_billed DESC
LIMIT 1;

-- shows how many documents every company uploaded
SELECT o.organisation_id,count(*) AS uploaded_documents
FROM organisation_analyst_documents as o
GROUP BY o.organisation_id;

-- shows the model, which got corrected the most

SELECT m.model_id,m.model_name, count(m.model_id) AS model_count
FROM extraction_models AS m
JOIN extraction_jobs AS e ON m.model_id = e.model_id
JOIN review_actions as r ON e.job_id = r.job_id
GROUP BY m.model_id,m.model_name
ORDER BY model_count DESC
LIMIT 1;

-- shows how many participants each user study had

SELECT s.study_id,s.study_description, count(sp.user_id) AS user_count
FROM studies AS s
JOIN study_participation AS sp ON s.study_id = sp.study_id
GROUP BY s.study_id,s.study_description
ORDER BY user_count DESC;

-- shows every participant and the average amount, of extraction task they completed per study
-- I inserted for the most users only one task they did per study, but user 12 did 3 tasks on
-- study 3 and 1 task on study 2, so on average he did just 2 task per study
SELECT s.user_id,avg(s.count)
FROM study_responses_session_study AS s
GROUP BY s.user_id






