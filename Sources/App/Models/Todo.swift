import Vapor
import FluentPostgreSQL

final class Todo: PostgreSQLModel {
    var id: Int?
    var title: String
    var finished: Bool

    init(id: Int? = nil, title: String, finished: Bool) {
        self.id = id
        self.title = title
        self.finished = finished
    }
}

extension Todo: Migration { }
extension Todo: Content { }
extension Todo: Parameter { }