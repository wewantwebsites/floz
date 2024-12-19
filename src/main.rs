#[macro_use]
extern crate rocket;

use rocket::serde::{json::Json, Deserialize, Serialize};
use rocket_db_pools::sqlx::{self, Row};
use rocket_db_pools::{Connection, Database};

#[derive(Database)]
#[database("floz")]
struct Db(sqlx::SqlitePool);

#[derive(Debug, Clone, Deserialize, Serialize)]
#[serde(crate = "rocket::serde")]
struct Question {
    question_id: Option<i64>,
    question_text: String,
}

#[get("/question/<id>")]
async fn read(mut db: Connection<Db>, id: i64) -> Option<Json<Question>> {
    println!("Fetching question with id: {}", id);
    sqlx::query("SELECT * FROM questions WHERE question_id = ?")
        .bind(id)
        .fetch_one(&mut **db)
        .await
        .map(|row| {
            let question_id = row.try_get("question_id").ok();
            let question_text = row.try_get("question_text").ok().unwrap_or_default();
            Json(Question {
                question_id,
                question_text,
            })
        })
        .ok()
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .attach(Db::init())
        .mount("/api", routes![read])
}
