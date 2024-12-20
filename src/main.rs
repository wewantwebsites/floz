use rocket::fs::FileServer;
use rocket::http::Method;
use rocket_cors::{AllowedOrigins, CorsOptions};
use rocket_db_pools::Database;

#[macro_use]
extern crate rocket;

mod db;
mod question;

#[launch]
fn rocket() -> _ {
    let args: Vec<String> = std::env::args().collect();

    let mut cors = CorsOptions::default()
        .allowed_methods(
            vec![Method::Get, Method::Post, Method::Patch, Method::Delete]
                .into_iter()
                .map(From::from)
                .collect(),
        )
        .allow_credentials(true);

    let r = rocket::build()
        .mount("/", FileServer::from("./static"))
        .attach(db::Db::init())
        .attach(question::stage());

    if args.len() > 1 && args[1] == "--dev" {
        println!("Running in dev mode");
        cors = cors.allowed_origins(AllowedOrigins::all());
    } else {
        println!("Running with strict cross origin policy");
        cors = cors.allowed_origins(AllowedOrigins::some(
            &["http://localhost:8000"],
            &["http://127.0.0.1:8000"],
        ));
    }
    println!("CORS enabled");

    r.attach(cors.to_cors().unwrap())
}
