CREATE TYPE EDUCATION_LEVELS as ENUM ('High School','Bachelor','Master','PhD','Other');


CREATE TABLE "User"(
    user_id SERIAL,
    age SMALLINT,
    education_level EDUCATION_LEVELS,

    CONSTRAINT User_pk PRIMARY KEY (user_id),
    CONSTRAINT User_values check ( age >= 16 )
);

CREATE TABLE Subscription(
    subscription_id SERIAL,
    subscription_name TEXT NOT NULL,
    max_user INTEGER NOT NULL,
    monthly_price NUMERIC(5,2),

    CONSTRAINT Subscription_pk PRIMARY KEY (subscription_id),
    CONSTRAINT Subscription_check_max_user CHECK ( max_user > 0 ),
    CONSTRAINT Subscription_check_monthly_price CHECK ( monthly_price > 0 ),
    CONSTRAINT Subscription_unique_name UNIQUE (subscription_name)

);

CREATE TABLE Organisations(
    organisation_id SERIAL,
    organisation_name TEXT,
    subscription_id INTEGER,

    CONSTRAINT Organisations_pk PRIMARY KEY (organisation_id),
    CONSTRAINT Organisations_fk_Subscription FOREIGN KEY (subscription_id)
        REFERENCES Subscription(subscription_id) ON DELETE RESTRICT

);


CREATE TABLE System_User(
    user_id INTEGER,
    organisation_id INTEGER NOT NULL,
    first_name TEXT,
    last_name TEXT,


    CONSTRAINT System_User_pk PRIMARY KEY(user_id),

    CONSTRAINT System_User_fk_User FOREIGN KEY (user_id)
        REFERENCES "User"(user_id) ON DELETE CASCADE,

    CONSTRAINT System_User_fk_Organisations FOREIGN KEY (organisation_id)
        REFERENCES Organisations(organisation_id) ON DELETE RESTRICT
);



CREATE TABLE Study_Participant(
    user_id INTEGER,
    completion_code TEXT,

    CONSTRAINT Study_Participant_pk PRIMARY KEY (user_id),
    CONSTRAINT Study_Participant_fk_User FOREIGN KEY (user_id)
        REFERENCES "User"(user_id) ON DELETE CASCADE

);

CREATE TABLE Studies (
    study_id SERIAL,
    study_description TEXT,

    CONSTRAINT Studies_pk PRIMARY KEY (study_id)

);

CREATE TABLE Study_Participation(
    study_id INTEGER,
    user_id INTEGER,

    CONSTRAINT Study_Participation_pk PRIMARY KEY (study_id,user_id),
    CONSTRAINT Study_Participation_fk_user FOREIGN KEY (user_id)
        REFERENCES Study_Participant (user_id) ON DELETE SET NULL,
    CONSTRAINT Study_Participation_fk_Studies FOREIGN KEY (study_id)
        REFERENCES Studies (study_id) ON DELETE SET NULL



);
-- each pair of user_id and study_id gets its own session
CREATE TABLE Study_Sessions(
    session_id SERIAL,
    session_date Date,
    user_id INTEGER NOT NULL,
    study_id INTEGER NOT NULL,


    CONSTRAINT Study_Sessions_pk PRIMARY KEY (session_id),
    CONSTRAINT Study_Sessions_fk_Participation FOREIGN KEY (user_id,study_id)
        REFERENCES Study_Participation (user_id,study_id) ON DELETE SET NULL
);

CREATE TABLE Study_Responses(
    response_id SERIAL,
    task_id INTEGER NOT NULL,
    user_response NUMERIC,
    session_id INTEGER,

    CONSTRAINT Study_Responses_pk PRIMARY KEY (response_id),
    CONSTRAINT Study_Responses_fk_Study_Sessions FOREIGN KEY (session_id)
        REFERENCES Study_Sessions(session_id) ON DELETE SET NULL

);

CREATE TABLE Analyst(
    user_id INTEGER,
    uploaded_documents INTEGER,

    CONSTRAINT Analyst_pk PRIMARY KEY (user_id),
    CONSTRAINT Analyst_fk_User FOREIGN KEY (user_id)
        REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE Reviewer(
    user_id INTEGER,
    reviewed_documents INTEGER,

    CONSTRAINT Reviewer_pk PRIMARY KEY (user_id),
    CONSTRAINT Reviewer_fk_User FOREIGN KEY (user_id)
        REFERENCES "User"(user_id) ON DELETE CASCADE
);

CREATE TABLE Org_Account_Information(
    organisation_id INTEGER,
    token TEXT,
    month_subscribed INTEGER DEFAULT 0,

    CONSTRAINT Org_Account_Information_pk PRIMARY KEY (organisation_id,token),
    CONSTRAINT Organisations_Information_fk_Organisations FOREIGN KEY (organisation_id)
        REFERENCES Organisations(organisation_id) ON DELETE CASCADE


);

CREATE TABLE Documents(
    document_id SERIAL,
    user_id INTEGER NOT NULL ,
    document_name TEXT,
    document_description TEXT,

    CONSTRAINT Documents_pk PRIMARY KEY (document_id),
    CONSTRAINT Documents_fk_Analyst FOREIGN KEY (user_id)
        REFERENCES Analyst(user_id) ON DELETE CASCADE


);
-- with accuracy the expected accuracy that got calculated  from Tests is meant
CREATE TABLE Extraction_Models(
    model_id SERIAL,
    model_name TEXT,
    accuracy NUMERIC(5,2) DEFAULT 0.00,

    CONSTRAINT Extraction_Models_pk PRIMARY KEY (model_id),
    CONSTRAINT Extraction_Models_check_accuracy CHECK ( accuracy >= 0.00 AND accuracy <= 100.00),
    CONSTRAINT Extraction_Models_Unique_name UNIQUE (model_name)



);

CREATE TABLE Extraction_Jobs(
    job_id SERIAL,
    document_id INTEGER NOT NULL,
    model_id INTEGER NOT NULL,

    CONSTRAINT Extraction_Jobs_pk PRIMARY KEY (job_id),
    CONSTRAINT Extraction_Jobs_fk_Documents FOREIGN KEY (document_id)
        REFERENCES Documents(document_id) ON DELETE CASCADE,
    CONSTRAINT Extraction_Jobs_fk_Extraction_Jobs FOREIGN KEY (model_id)
        REFERENCES Extraction_Models(model_id) ON DELETE CASCADE

);

CREATE TABLE Extracted_Values(
    job_id INTEGER,
    value_number SERIAL,
    value NUMERIC,
    unit TEXT,

    CONSTRAINT Extracted_Values_pk PRIMARY KEY (value_number,job_id),
    CONSTRAINT Extracted_Values_fk_Extraction_jobs FOREIGN KEY (job_id)
        REFERENCES Extraction_Jobs(job_id) ON DELETE SET NULL
);

CREATE TABLE Review_Actions(
    action_id SERIAL,
    user_id INTEGER NOT NULL,
    value_number INTEGER,
    job_id INTEGER,
    review_date DATE,
    changed_value NUMERIC,
    changed_unit TEXT,

    CONSTRAINT Review_Actions_pk PRIMARY KEY (action_id),
    CONSTRAINT Review_Actions_fk_user FOREIGN KEY (user_id)
        REFERENCES Reviewer(user_id) ON DELETE SET NULL,
    CONSTRAINT Review_Actions_fk_Extracted_Values FOREIGN KEY (value_number,job_id)
        REFERENCES Extracted_Values(value_number,job_id) ON DELETE SET NULL


);
