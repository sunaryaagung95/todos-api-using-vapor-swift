import Vapor

final class TodoController {
    // query all todos
    func index(_ req: Request) throws -> Future<[Todo]> {
        return Todo.query(on: req).all()
    }

    //get one todo
    func show(_ req: Request) throws -> Future<Todo> {
        return try req.parameters.next(Todo.self)
    }

    func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap(to: Todo.self) {
            todo in
                return todo.save(on: req)
        }
    }

    func update(_ req: Request) throws -> Future<Todo> {
        return try flatMap(to: Todo.self, req.parameters.next(Todo.self), req.content.decode(Todo.self)) {
            todo, updatedTodo in
                todo.title = updatedTodo.title
                todo.finished = updatedTodo.finished
                return todo.save(on: req)
        }    
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap(to: Void.self) {todo in 
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
}