Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :feeds
    resources :feed_statuses
    resources :stories
  end
end
