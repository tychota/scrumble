angular.module 'Scrumble.storage'
.factory 'Project', (Parse, $q) ->
  class Project extends Parse.Model
    @configure "Project", "boardId", "name", "columnMapping", "team", "currentSprint", "settings"

    @get = (boardId) ->
      deferred = $q.defer()

      if boardId?
        @query(
          where:
            boardId: boardId
        ).then (projectsArray) ->
          project = if projectsArray.length > 0 then projectsArray[0] else null
          deferred.resolve project
        .catch deferred.reject
      else
        deferred.reject 'No boardId'
      deferred.promise

    @saveTitle = (project, title) ->
      project.settings ?= {}
      project.settings.bdcTitle = title
      project.save().then ->
        title
