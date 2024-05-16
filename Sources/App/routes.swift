import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: BandsController())

    // localhost:8080/band/retro-rewind
    // app.get("band", ":slug") { req async throws in
    //     let slug = try req.parameters.require("slug")
    //     guard let band = try await Band.findBySlug(slug, on: req.db) else {
    //         throw Abort(.notFound)
    //     }
    //
    //     return band
    // }

    // app.get("band", ":slug", "songs") { req async throws in 
    //     let slug = try req.parameters.require("slug")
    //     guard let band = try await Band.findBySlug(slug, on: req.db) else {
    //         throw Abort(.notFound)
    //     }
    //
    //     return try await band.$songs.query(on: req.db).all()
    // }
}
