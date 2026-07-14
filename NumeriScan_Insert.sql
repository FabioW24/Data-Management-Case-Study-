INSERT INTO "User" (age, education_level)
VALUES
    (19,'High School'),
    (23,'Bachelor'),
    (34,'PhD'),
    (26,'Master'),
    (56,'Bachelor'),
    (16,'High School'),
    (27,'Master'),
    (45,'PhD'),
    (25,'Master'),
    (56,'Bachelor'),
    (19,'High School'),
    (40,'High School'),
    (21,'Bachelor'),
    (35,'Master'),
    (67,'Master');

-- I modeled max_user because it makes sense to limit the user amount based on
-- the Subscription plan, note that I am aware that it needs a trigger on Insert of,
-- System_User that checks if he is part of an Organisation, which would exceed the limit of users.
INSERT INTO subscription (subscription_name, max_user, monthly_price)
VALUES
    ('Standard',25,149.99),
    ('Standard Small',5,49.99),
    ('Standard Solo',1,19.99),
    ('Premium',50,249.99),
    ('Premium Deluxe',100,449.99);

INSERT INTO organisations(organisation_name, subscription_id)
VALUES
    ('Rush University Medical Center',1),
    ('Binary Brothers',2),
    ('Pauls´s Data Science Projekt',3),
    ('Steam',4),
    ('Google',5);

INSERT INTO system_user(user_id, organisation_id, first_name, last_name)
VALUES
    (2,1,'Jonathan','Black'),
    (4,4,'Jason','Jester'),
    (3,5,'Christian','Thorn'),
    (1,3,'Paul','Slater'),
    (8,5,'Dean','Schneider'),
    (15,4,'George','Light'),
    (13,2,'Mason','Owner'),
    (7,2,'Ferdinand','Owner'),
    (12,1,'Obiman','Osas'),
    (10,5,'Bernd','Dino'),
    (5,4,'Timo','Saladino');

INSERT INTO study_participant(user_id, completion_code)
VALUES (3,'D6E6'),
       (9,'H21A'),
       (11,'U78C'),
       (12,'KL87'),
       (4,'N3V6'),
       (15,'BS11'),
       (13,'JG66'),
       (10,'FF55'),
       (2,'T2Z9'),
       (6,'5AY1'),
       (14,'9ZA0'),
       (7,'U05D');

INSERT INTO studies(study_description)
VALUES ('Participants Analyse First Extraction Model'),
       ('Quiz study, simple mathematics puzzle evaluating answers based on education level'),
       ('Advanced Model Test this Model without subscription and give feedback');


INSERT INTO study_participation(user_id,study_id)
VALUES
    (3, 1),
    (9, 2),
    (11, 1),
    (12, 3),
    (4, 2),
    (15, 1),
    (13, 3),
    (10, 2),
    (2, 1),
    (6, 3),
    (14, 2),
    (7, 1);

INSERT INTO study_participation(user_id,study_id)
VALUES (12,2);

INSERT INTO study_sessions(session_date, user_id, study_id)
VALUES
    ('2026-07-01', 3, 1),
    ('2026-07-02', 9, 2),
    ('2026-07-02', 11, 1),
    ('2026-07-03', 12, 3),
    ('2026-07-03', 4, 2),
    ('2026-07-04', 15, 1),
    ('2026-07-05', 13, 3),
    ('2026-07-05', 10, 2),
    ('2026-07-06', 2, 1),
    ('2026-07-06', 6, 3),
    ('2026-07-07', 14, 2),
    ('2026-07-07', 7, 1);

-- i added it later
INSERT INTO study_sessions(session_date, user_id, study_id)
VALUES ('2026-07-02',12,2);


INSERT INTO study_responses(task_id, user_response, session_id)
VALUES (11,348.55,1),
       (21,0.10,2),
       (11,348.55,3),
       (31,68747.98,4),
       (21,0.20,5),
       (11,200.00,6),
       (31,68747.98,7),
       (21,0.10,8),
       (11,348.90,9),
       (31,23.56,10),
       (21,0.10,11),
       (11,348.55,12);

INSERT INTO study_responses(task_id, user_response, session_id)
VALUES (32,8738,4),
       (33,0.21,4),
       (22,33,5);

INSERT INTO study_responses(task_id, user_response, session_id)
VALUES (21,0.10,13);

-- need Trigger that Triggers on Insert into Documents, to ensure to count
-- uploaded documents for each Analyst, I will leave that to NULL for now

INSERT INTO analyst (user_id)
VALUES (3),
       (15),
       (4),
       (1),
       (13),
       (10);
INSERT INTO analyst (user_id)
VALUES (12);
-- same with here I will leave it to NULL
INSERT INTO reviewer(user_id)
VALUES (1),
       (5),
       (7),
       (8),
       (2);

INSERT INTO org_account_information(organisation_id, token, month_subscribed)
VALUES (1,'RTF-546-IZH',27),
       (2,'ZUH-UZJ-765',13),
       (3,'TBO-611-KVF',2),
       (4,'SYB-HTV-789',12),
       (5,'HZV-LPU-980',16);



INSERT INTO documents(user_id, document_name, document_description)
VALUES (3,'User Analasyls','Googles User Analasyls of January 2026'),
       (1,'Measured Values','Data Analasyls on AI influencing performance'),
       (12,'fiber study','study on how dietary fiber act in the human body '),
       (15,'most played games','most games played on steam January 2026'),
       (13,'x86 Assembly usage','how does does x86 Assembly usage in modern Linux distributions changed over time');


INSERT INTO extraction_models(model_name, accuracy)
VALUES ('Standard Numeri Scanner',0.70),
       ('Advanced Numeri Scanner',0.85),
       ('Advanced Numeri Scanner1.1',0.90),
       ('Advanced Numeri Scanner1.2',0.95);

INSERT INTO extraction_jobs(document_id, model_id)
VALUES (1,4),
       (2,1),
       (3,3),
       (4,4),
       (5,2);

INSERT INTO extracted_values(job_id, value, unit)
VALUES (1,256090.00,'people'),
       (1,0.54,'percent'),
       (1,23433.00,'people'),
       (2,0.32,'percent'),
       (2,77.00,'people'),
       (2,0.83,'percent'),
       (3,0.45,'percent'),
       (3,200,'percent'),
       (3,169,'people'),
       (4,7483,'Games'),
       (4,8374834,'Player'),
       (4,0.94,'percent'),
       (5,373878,'Assembly instructions'),
       (5,0.11,'Percent'),
       (5,0.89,'Percent');

-- there is a little problem, that reviewer can review documents, from Organizations they do not belong to,
-- I do not how common that would be in practice but on the manual insert it is possible
INSERT INTO review_actions(user_id, value_number, job_id, review_date, changed_value)
VALUES (8,31,1,'2026-02-15',254090.00),
       (1,4,2,'2026-06-02',0.45),
       (7,13,5,'2026-04-10',273879),
       (2,7,3,'2025-10-24',0.48);


INSERT INTO extracted_values(job_id,value,unit)
VALUES (3,2.22,'kilogramms');

INSERT INTO review_actions(user_id,value_number,job_id,review_date,changed_value)
VALUES (1,5,2,'2026-03-12',78);



