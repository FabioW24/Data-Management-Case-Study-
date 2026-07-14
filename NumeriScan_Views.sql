-- I highly appreciate using views in databases in the 3rd normal form (3NF)
-- to combine highly normalized relations and achieve a better overview.
-- Therefore, I added a couple of views to the database, especially since
-- this aggregated information can be used for multiple subsequent queries.

-- with that view you can see how often a Document
-- participates in Extracted Values
CREATE OR REPLACE VIEW document_job_id_extracted_values AS
    SELECT d.document_name,j.document_id,v.job_id
    FROM Documents As d
    JOIN extraction_jobs AS j ON d.document_id = j.document_id
    JOIN extracted_values AS v ON j.job_id = v.job_id;

-- with this View it is easy to query how many documents every Organisation uploaded
CREATE OR REPLACE VIEW organisation_Analyst_documents AS
    SELECT s.organisation_id,a.user_id,d.document_id
FROM System_User AS s
JOIN Analyst AS a ON s.user_id = a.user_id
JOIN Documents AS d ON a.user_id = d.user_id;


-- this view shows you how many tasks a user did on a study
CREATE OR REPLACE VIEW study_responses_session_study AS
    SELECT s.study_id, s.user_id, count(r.task_id)
    FROM Study_Sessions AS s
    JOIN Study_Responses r on s.session_id = r.session_id
    GROUP BY s.study_id, s.user_id



