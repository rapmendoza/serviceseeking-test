require 'rails_helper'

RSpec.describe Todo::Create do
  before do
    @user = User.create!(fullname: "Guest")
  end

  context "user fills up todo title" do
    it "should create a todo list" do
      expect(TodoList.count).to eq(0)
      todo_create_method("clean my car")
      expect(TodoList.count).to eq(1)
    end
  end

  context "user does not fill up todo title" do
    it "should not create a todo list" do
      expect(TodoList.count).to eq(0)
      todo_create_method
      expect(TodoList.count).to eq(0)
    end
  end
end

def todo_create_method(tdlname = "")
  todo_list = TodoList.new(name: tdlname)
  todo_list.user = @user
  todo_list.save! if todo_list.name.present?
end

# Todo::Create.()
# .run { asd}