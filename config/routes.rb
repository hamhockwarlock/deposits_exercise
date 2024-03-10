Rails.application.routes.draw do

  # GET /tradelines/:id
  # GET /tradelines
  resources :tradelines, only: %i[index show] do
    # POST /tradelines/:id/deposits
    resources :deposits, only: %[create]
  end
end
