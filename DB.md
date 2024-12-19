# Database Instructions

This documentation is for common commands and queries ran against the database. There are files for creating tables and hydrating

## Queries

### Get All Questions in a Specific Workflow

```sql
SELECT q.question_text, wq.question_type, wq.sequence
FROM WorkflowQuestions wq
JOIN Questions q ON wq.question_id = q.question_id
WHERE wq.workflow_id = 1
ORDER BY wq.sequence;
```

### Get User Answers for a Specific Question

```sql
SELECT ua.answer_text
FROM UserAnswers ua
WHERE ua.question_id = 1;
```

### Get Metadata for a Specific Workflow Question

```sql
SELECT m.metadata_key, m.metadata_value
FROM WorkflowQuestionMetadata wqm
JOIN Metadata m ON wqm.metadata_id = m.metadata_id
WHERE wqm.workflow_question_id = 1;
```

### Get Conditions for a Specific Workflow Question

```sql
SELECT c.condition_description
FROM WorkflowQuestionConditions wqc
JOIN Conditions c ON wqc.condition_id = c.condition_id
WHERE wqc.workflow_question_id = 1;
```

### Get All Workflows a Specific User Has Answers For

```sql
SELECT DISTINCT w.workflow_name, w.workflow_description
FROM UserAnswers ua
JOIN Questions q ON ua.question_id = q.question_id
JOIN WorkflowQuestions wq ON q.question_id = wq.question_id
JOIN Workflows w ON wq.workflow_id = w.workflow_id
WHERE ua.user_id = 1;
```
