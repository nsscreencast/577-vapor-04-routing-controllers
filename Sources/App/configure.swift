import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

private struct MissingDatabaseCredentials: Error {}

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    guard
        let dbUser = Environment.get("DATABASE_USERNAME"),
        let dbPass = Environment.get("DATABASE_PASSWORD"),
        let dbName = Environment.get("DATABASE_NAME")
    else {
        throw MissingDatabaseCredentials()
    }

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: dbUser,
        password: dbPass,
        database: dbName,
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    app.migrations.add(CreateBands())
    app.migrations.add(CreateSongs())
    app.migrations.add(CreateArtists())

    // register routes
    try routes(app)
}
