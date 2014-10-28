App.ApplicationController = Ember.Controller.extend
  needs: ['login'],

  isAuthenticated: (->
    !Ember.isEmpty(@get('controllers.login.token'))
  ).property('controllers.login.token')

  currentUser: (->
    @get('controllers.login.currentUser').user
  ).property('controllers.login.currentUser')


