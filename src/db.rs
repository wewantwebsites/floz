use rocket_db_pools::sqlx::SqlitePool;
use rocket_db_pools::Database;

#[derive(Database)]
#[database("floz")]
pub struct Db(SqlitePool);
