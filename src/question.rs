use crate::db;

use rocket::fairing::AdHoc;
use rocket::response::status::Created;
use rocket::serde::{json::Json, Deserialize, Serialize};
use rocket_db_pools::sqlx::sqlite::SqliteRow;
use rocket_db_pools::sqlx::{self, Row};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(crate = "rocket::serde")]
pub struct Question {
    #[serde(skip_serializing_if = "Option::is_none")]
    question_id: Option<i64>,
    question_text: String,
}

impl Question {
    pub fn from_sqlite_row(row: SqliteRow) -> Self {
        Self {
            question_id: row.try_get("question_id").ok(),
            question_text: row.try_get("question_text").ok().unwrap_or_default(),
        }
    }
}
fn map_question(row: SqliteRow) -> Question {
    Question::from_sqlite_row(row)
}

type Result<T, E = rocket::response::Debug<sqlx::Error>> = std::result::Result<T, E>;

#[get("/question/<id>")]
pub async fn read(mut db: Connection<db::Db>, id: i64) -> Option<Json<Question>> {
    println!("Fetching question with id: {}", id);
    sqlx::query("SELECT * FROM questions WHERE question_id = ?")
        .bind(id)
        .fetch_one(&mut **db)
        .await
        .map(map_question)
        .map(Json)
        .ok()
}

#[get("/question")]
pub async fn read_all(mut db: Connection<db::Db>) -> Option<Json<Vec<Question>>> {
    println!("Fetching all questions");
    sqlx::query("SELECT * FROM questions")
        .fetch_all(&mut **db)
        .await
        .map(|rows| rows.into_iter().map(map_question).collect())
        .map(Json)
        .ok()
}

#[post("/question", data = "<question>")]
pub async fn create(
    mut db: Connection<db::Db>,
    mut question: Json<Question>,
) -> Result<Created<Json<Question>>> {
    println!("Creating question: {:?}", question);

    let results =
        sqlx::query("INSERT INTO questions (question_text) VALUES (?) RETURNING question_id")
            .bind(&question.question_text)
            .fetch_one(&mut **db)
            .await
            .map(Question::from_sqlite_row)?;

    question.question_id = results.question_id;
    Ok(Created::new("/question").body(question))
}

pub fn stage() -> AdHoc {
    AdHoc::on_ignite("Question Stage", |rocket| async {
        rocket.mount("/api", routes![read, read_all, create])
    })
}
