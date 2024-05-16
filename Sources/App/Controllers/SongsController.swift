import Vapor
import Fluent

struct SongsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let songs = routes.grouped("songs")

        songs.get(use: index)
    }

    @Sendable
    func index(req: Request) async throws -> [Song] {
        let slug = try req.parameters.require("slug")
        guard let band = try await Band.findBySlug(slug, on: req.db) else {
            throw Abort(.notFound)
        }

        return try await band.$songs.query(on: req.db).all()
    }
}
