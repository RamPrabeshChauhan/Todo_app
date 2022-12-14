class Api::V1::TodoController < ApplicationController

    before_action :todoId, only: [:updateTodo, :deleteTodo, :deleteUndoTodo]
    
    # ─── Create Todo ────────────────────────────────────────────────────────────────
    def addTodo
        
        # # method 1
        # todo = Todomodel.new(tag: params[:tag], body: params[:body])

        # method 2 
        todo = Todomodel.new(todoParams)
        
        if todo.save()
            render json: {msg: "Todo added successfully!!"}, status: :ok
        else
            render json: {msg:"Todo adding unsuccessful....", error: todo.errors }, status: :unprocessable_entity
        end
    end
    
    
    # ─── Show All Todo ──────────────────────────────────────────────────────────────
    def getTodo
        
        # todo = Todomodel.all
        # if todo 
        #     render json: todo, status: :ok
        # else
        #     render json: {msg: "Todo list is empty...."}, status: :unprocessable_entity
        # end

        todo = Todomodel.where.not(visible: false)
            if todo
                render json: todo
            else
                render json: {msg: 'The database is empty....'}
            end
    end
    # ─── Show Todo In Pagination ────────────────────────────────────────────────────
    def getIndex

        todo = Todomodel.all.page params[:page]

        if todo 
            render json: todo, status: :ok
        else
            render json: {msg: "Todo items in pagination viwe faild...."}, status: :unprocessable_entity
        end
        
    end
    # ─── Finding Todo Item By Tag ───────────────────────────────────────────────────
    def showTodo
        
        todo = Todomodel.where(tag: params[:tag])

        if todo 
            render json: todo, status: :ok
        else
            render json: {msg: "Todo item not found...."}, status: :unprocessable_entity
        end
    end


    # ─── Update Todo ────────────────────────────────────────────────────────────────
    def updateTodo

        if @todoId
            if @todoId.update(todoParams)
                render json: {msg: "Todo got updated!!"}, status: :ok
            else
                render json: {msg: "Todo updating got failed...."}, error: @todoId.errors, status: :unprocessable_entity
            end
        end 

    end


    # ─── Delete Todo ────────────────────────────────────────────────────────────────
    def deleteTodo
        # # To Delete permanently from todo database. 
        # if @todoId
        #     if @todoId.destroy(todoParams)
        #         render json: {msg: "Todo has deleted!!"}, status: :ok
        #     else
        #         render json: {msg: "Todo deleting got failed..."}, status: :unprocessable_entity
        #     end
        # end

        # Undo feature but it won't delete any data.
        if @todoId
            if @todoId.update(visible: false)
                render json: {msg: "Todo has deleted!!"}, status: :ok
            else
                render json: {msg: "Todo deleting got failed...."}, status: :unprocessable_entity
            end
        end
    end
    # ─── Undo Todo ──────────────────────────────────────────────────────────────────
    def deleteUndoTodo
        if @todoId
            if @todoId.update(visible: true)
                render json: {msg: "Todo has Undo!!"}, status: :ok
            else
                render json: {msg: "Todo undoing got failed...."}, status: :unprocessable_entity
            end
        end
    end



    # Passing todo item id and params
    private 
        def todoParams
            params.permit(:tag, :title, :body, :status, :visible);
        end

        def todoId
            @todoId = Todomodel.find(params[:id])
        end
end
