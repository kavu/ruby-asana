### WARNING: This file is auto-generated by the asana-api-meta repo. Do not
### edit it manually.
require_relative 'resource'

module Asana
  module Resources
    # The _task_ is the basic object around which many operations in Asana are
    # centered. In the Asana application, multiple tasks populate the middle pane
    # according to some view parameters, and the set of selected tasks determines
    # the more detailed information presented in the details pane.
    class Task < Resource

      attr_reader :assignee

      attr_reader :assignee_status

      class << self
        # Returns the plural name of the resource.
        def plural_name
          'tasks'
        end

        # Creating a new task is as easy as POSTing to the `/tasks` endpoint
        # with a data block containing the fields you'd like to set on the task.
        # Any unspecified fields will take on default values.
        #
        # Every task is required to be created in a specific workspace, and this
        # workspace cannot be changed once set. The workspace need not be set
        # explicitly if you specify a `project` or a `parent` task instead.
        #
        # data - [Hash] the attributes to post.
        def create(data = {}, client:)

          new(body(client.post("/tasks", body: data)), client: client)
        end

        # Creating a new task is as easy as POSTing to the `/tasks` endpoint
        # with a data block containing the fields you'd like to set on the task.
        # Any unspecified fields will take on default values.
        #
        # Every task is required to be created in a specific workspace, and this
        # workspace cannot be changed once set. The workspace need not be set
        # explicitly if you specify a project or a parent task instead.
        #
        # data - [Hash] the attributes to post.
        # workspace - [Id] The workspace to create a task in.
        def create_in_workspace(data = {}, workspace:, client:)

          new(body(client.post("/workspaces/#{workspace}/tasks", body: data)), client: client)
        end

        # Returns the complete task record for a single task.
        #
        # id - [Id] The task to get.
        def find_by_id(id, client:)

          new(body(client.get("/tasks/#{id}")), client: client)
        end

        # Returns the compact task records for all tasks within the given project,
        # ordered by their priority within the project.
        #
        # projectId - [Id] The project in which to search for tasks.
        def find_by_project(projectId:, client:)

          Collection.new(body(client.get("/projects/#{projectId}/tasks")), client: client)
        end

        # Returns the compact task records for all tasks with the given tag.
        #
        # tag - [Id] The tag in which to search for tasks.
        def find_by_tag(tag:, client:)

          Collection.new(body(client.get("/tags/#{tag}/tasks")), client: client)
        end

        # Returns the compact task records for some filtered set of tasks. Use one
        # or more of the parameters provided to filter the tasks returned.
        #
        # assignee - [Id] The assignee to filter tasks on.
        # workspace - [Id] The workspace or organization to filter tasks on.
        # completed_since - [String] Only return tasks that are either incomplete or that have been
        # completed since this time.
        #
        # modified_since - [String] Only return tasks that have been modified since the given time.
        #
        # Notes:
        #
        # If you specify `assignee`, you must also specify the `workspace` to filter on.
        #
        # If you specify `workspace`, you must also specify the `assignee` to filter on.
        #
        # A task is considered "modified" if any of its properties change,
        # or associations between it and other objects are modified (e.g.
        # a task being added to a project). A task is not considered modified
        # just because another object it is associated with (e.g. a subtask)
        # is modified. Actions that count as modifying the task include
        # assigning, renaming, completing, and adding stories.
        def find_all(assignee: nil, workspace: nil, completed_since: nil, modified_since: nil, client:)
          params = { assignee: assignee, workspace: workspace, completed_since: completed_since, modified_since: modified_since }.reject { |_,v| v.nil? }
          Collection.new(body(client.get("/tasks", params: params)), client: client)
        end

        # Adds each of the specified followers to the task, if they are not already
        # following. Returns the complete, updated record for the affected task.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to add followers to.
        # followers - [Array] An array of followers to add to the task.
        def add_followers(data = {}, task:, followers:, client:)
          params = { followers: followers }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/addFollowers", body: params)), client: client)
        end

        # Removes each of the specified followers from the task if they are
        # following. Returns the complete, updated record for the affected task.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to remove followers from.
        # followers - [Array] An array of followers to remove from the task.
        def remove_followers(data = {}, task:, followers:, client:)
          params = { followers: followers }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/removeFollowers", body: params)), client: client)
        end

        # Returns a compact representation of all of the projects the task is in.
        #
        # task - [Id] The task to get projects on.
        def projects(task:, client:)

          Collection.new(body(client.get("/tasks/#{task}/projects")), client: client)
        end

        # Adds the task to the specified project, in the optional location
        # specified. If no location arguments are given, the task will be added to
        # the beginning of the project.
        #
        # `addProject` can also be used to reorder a task within a project that
        # already contains it.
        #
        # Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to add to a project.
        # project - [Id] The project to add the task to.
        # insertAfter - [Id] A task in the project to insert the task after, or `null` to
        # insert at the beginning of the list.
        #
        # insertBefore - [Id] A task in the project to insert the task before, or `null` to
        # insert at the end of the list.
        #
        # section - [Id] A section in the project to insert the task into. The task will be
        # inserted at the top of the section.
        def add_project(data = {}, task:, project:, insertAfter: nil, insertBefore: nil, section: nil, client:)
          params = { project: project, insertAfter: insertAfter, insertBefore: insertBefore, section: section }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/addProject", body: params)), client: client)
        end

        # Removes the task from the specified project. The task will still exist
        # in the system, but it will not be in the project anymore.
        #
        # Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to remove from a project.
        # project - [Id] The project to remove the task from.
        def remove_project(data = {}, task:, project:, client:)
          params = { project: project }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/removeProject", body: params)), client: client)
        end

        # Returns a compact representation of all of the tags the task has.
        #
        # task - [Id] The task to get tags on.
        def tags(task:, client:)

          Collection.new(body(client.get("/tasks/#{task}/tags")), client: client)
        end

        # Adds a tag to a task. Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to add a tag to.
        # tag - [Id] The tag to add to the task.
        def add_tag(data = {}, task:, tag:, client:)
          params = { tag: tag }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/addTag", body: params)), client: client)
        end

        # Removes a tag from the task. Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to remove a tag from.
        # tag - [Id] The tag to remove from the task.
        def remove_tag(data = {}, task:, tag:, client:)
          params = { tag: tag }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/removeTag", body: params)), client: client)
        end

        # Returns a compact representation of all of the subtasks of a task.
        #
        # task - [Id] The task to get the subtasks of.
        def subtasks(task:, client:)

          Collection.new(body(client.get("/tasks/#{task}/subtasks")), client: client)
        end

        # Makes an existing task a subtask of another. Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to add a subtask to.
        # subtask - [Id] The subtask to add to the task.
        def add_subtask(data = {}, task:, subtask:, client:)
          params = { subtask: subtask }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/subtasks", body: params)), client: client)
        end

        # Changes the parent of a task. Each task may only be a subtask of a single
        # parent, or no parent task at all. Returns an empty data block.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] The task to change the parent of.
        # parent - [Id] The new parent of the task, or `null` for no parent.
        def set_parent(data = {}, task:, parent:, client:)
          params = { parent: parent }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/setParent", body: params)), client: client)
        end

        # Returns a compact representation of all of the stories on the task.
        #
        # task - [Id] The task containing the stories to get.
        def stories(task:, client:)

          Collection.new(body(client.get("/tasks/#{task}/stories")), client: client)
        end

        # Adds a comment to a task. The comment will be authored by the
        # currently authenticated user, and timestamped when the server receives
        # the request.
        #
        # Returns the full record for the new story added to the task.
        #
        # data - [Hash] the attributes to post.
        # task - [Id] Globally unique identifier for the task.
        #
        # text - [String] The plain text of the comment to add.
        def add_comment(data = {}, task:, text:, client:)
          params = { text: text }.reject { |_,v| v.nil? }
          new(body(client.post("/tasks/#{task}/stories", body: params)), client: client)
        end
      end

      # A specific, existing task can be updated by making a PUT request on the
      # URL for that task. Only the fields provided in the `data` block will be
      # updated; any unspecified fields will remain unchanged.
      #
      # When using this method, it is best to specify only those fields you wish
      # to change, or else you may overwrite changes made by another user since
      # you last retrieved the task.
      #
      # Returns the complete updated task record.
      #
      # data - [Hash] the attributes to post.
      def update(data = {})
        refresh_with(body(client.put("/tasks/#{id}", body: data)))
      end

      # A specific, existing task can be deleted by making a DELETE request on the
      # URL for that task. Deleted tasks go into the "trash" of the user making
      # the delete request. Tasks can be recovered from the trash within a period
      # of 30 days; afterward they are completely removed from the system.
      #
      # Returns an empty data record.
      def delete()
        client.delete("/tasks/#{id}") && true

      end

    end
  end
end

