use actix_web::HttpResponse;
use actix_web::http::header::ContentType as ContextType;

pub async fn home() -> HttpResponse {
    HttpResponse::Ok()
        .content_type(ContextType::html())
        .body(include_str!("home.html"))
}
