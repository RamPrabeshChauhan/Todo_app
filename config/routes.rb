Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # "add_Todo" = query name
      # "addTodo" = which method will execute
      # "todo" = controller file name inside api>v1>todo.rb
      post "add_Todo", action: :addTodo, controller: :todo
      get "show_Todos", action: :getTodo, controller: :todo
      get "show_Index", action: :getIndex, controller: :todo
      get "show_Tag", action: :showTodo, controller: :todo
      put "update_Todo", action: :updateTodo, controller: :todo
      delete "delete_Todo", action: :deleteTodo, controller: :todo
      delete "undo_Todo", action: :deleteUndoTodo, controller: :todo
    end
  end
end
