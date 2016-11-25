class Todo::Create < Trailblazer::Operation

  def process(params)
    title           = params[:todo][:title]
    todo_list_id    = params[:todo_list_id]
    current_user    = params[:current_user]
    current_user_id = params[:current_user_id]

    return invalid! if title.blank?

    todo = @model = Todo.new(params.require(:todo).permit(:title, :description))

    if todo_list_id.blank?
      todo_list = TodoList.find_or_create_by(name: "Default To-do List")

      todo_list.user =
        if current_user == nil
          if current_user_id == nil
            User.create!(fullname: "Guest")
          else
            User.find(current_user_id)
          end
        else
          current_user
        end

      todo_list.save!
    else
      todo_list = TodoList.find(todo_list_id)
    end

    todo.list = todo_list
    todo.save!
  end

end
