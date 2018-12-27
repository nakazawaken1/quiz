require 'rails_helper'

describe 'users', type: :request do
  it 'create user' do
    get '/signup'
    expect(response).to render_template(:new)

    post '/users/create', params: { name: 'testname', mail: 'mail@test', password: 'testpassword', password_confirmation: 'testpassword' }

    expect(response).to redirect_to('/')
    follow_redirect!

    expect(response).to render_template(:home)
    expect(response.body).to include(I18n.t(:user_created))
  end
end