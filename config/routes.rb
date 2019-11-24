# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: routes.rb
# Description: This files handles all the routes.
# Last modified on: 11/24/19


Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :users
  resources :professors
  resources :students
  resources :courses
  resources :waitlists
  resources :enrolled_courses

  get '/courses/:id/roster/', to: 'courses#roster', as: 'roster'
  get 'home/faqs'
  get 'home/dashboard'
  root 'home#home'
end
