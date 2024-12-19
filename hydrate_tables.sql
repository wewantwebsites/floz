INSERT INTO Questions (question_text) VALUES ('What is your name?');
INSERT INTO Questions (question_text) VALUES ('What is your age?');

INSERT INTO Workflows (workflow_name, workflow_description) VALUES ('User Registration', 'Workflow for registering new users');
INSERT INTO Workflows (workflow_name, workflow_description) VALUES ('Survey', 'Workflow for collecting survey responses');

INSERT INTO WorkflowQuestions (workflow_id, question_id, question_type, sequence) VALUES (1, 1, 'text', 1);
INSERT INTO WorkflowQuestions (workflow_id, question_id, question_type, sequence) VALUES (1, 2, 'number', 2);
INSERT INTO WorkflowQuestions (workflow_id, question_id, question_type, sequence) VALUES (2, 1, 'text', 1);

INSERT INTO Users (user_name) VALUES ('John Doe');
INSERT INTO Users (user_name) VALUES ('Jane Smith');

INSERT INTO UserAnswers (user_id, question_id, answer_text) VALUES (1, 1, 'John Doe');
INSERT INTO UserAnswers (user_id, question_id, answer_text) VALUES (1, 2, '30');
INSERT INTO UserAnswers (user_id, question_id, answer_text) VALUES (2, 1, 'Jane Smith');

INSERT INTO Metadata (metadata_key, metadata_value) VALUES ('priority', 'high');
INSERT INTO Metadata (metadata_key, metadata_value) VALUES ('category', 'personal');

INSERT INTO WorkflowQuestionMetadata (workflow_question_id, metadata_id) VALUES (1, 1);
INSERT INTO WorkflowQuestionMetadata (workflow_question_id, metadata_id) VALUES (2, 2);

INSERT INTO Conditions (condition_description) VALUES ('Must be 18 or older');
INSERT INTO Conditions (condition_description) VALUES ('Answer must not be empty');

INSERT INTO WorkflowQuestionConditions (workflow_question_id, condition_id) VALUES (2, 1);
INSERT INTO WorkflowQuestionConditions (workflow_question_id, condition_id) VALUES (2, 2);
