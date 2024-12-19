CREATE TABLE Questions ( 
  question_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  question_text TEXT NOT NULL 
); 

CREATE TABLE Workflows ( 
  workflow_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  workflow_name TEXT NOT NULL, 
  workflow_description TEXT 
); 

CREATE TABLE WorkflowQuestions ( 
  workflow_question_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  workflow_id INTEGER NOT NULL, 
  question_id INTEGER NOT NULL, 
  question_type TEXT NOT NULL, 
  sequence INTEGER NOT NULL, 
  FOREIGN KEY (workflow_id) REFERENCES Workflows(workflow_id), 
  FOREIGN KEY (question_id) REFERENCES Questions(question_id) 
); 

CREATE TABLE Users ( 
  user_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  user_name TEXT NOT NULL 
); 

CREATE TABLE UserAnswers ( 
  answer_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  user_id INTEGER NOT NULL, 
  question_id INTEGER NOT NULL, 
  answer_text TEXT NOT NULL, 
  FOREIGN KEY (user_id) REFERENCES Users(user_id), 
  FOREIGN KEY (question_id) REFERENCES Questions(question_id) 
); 

CREATE TABLE Metadata ( 
  metadata_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  metadata_key TEXT NOT NULL, 
  metadata_value TEXT NOT NULL 
); 

CREATE TABLE WorkflowQuestionMetadata ( 
  workflow_question_metadata_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  workflow_question_id INTEGER NOT NULL, 
  metadata_id INTEGER NOT NULL, 
  FOREIGN KEY (workflow_question_id) REFERENCES WorkflowQuestions(workflow_question_id), 
  FOREIGN KEY (metadata_id) REFERENCES Metadata(metadata_id) 
); 

CREATE TABLE Conditions ( 
  condition_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  condition_description TEXT NOT NULL 
); 

CREATE TABLE WorkflowQuestionConditions ( 
  workflow_question_condition_id INTEGER PRIMARY KEY AUTOINCREMENT, 
  workflow_question_id INTEGER NOT NULL, 
  condition_id INTEGER NOT NULL, 
  FOREIGN KEY (workflow_question_id) REFERENCES WorkflowQuestions(workflow_question_id), 
  FOREIGN KEY (condition_id) REFERENCES Conditions(condition_id) 
); 
