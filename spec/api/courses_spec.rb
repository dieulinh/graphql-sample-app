require 'rails_helper'

RSpec.describe Courses, type: :request do
  let(:user) { Student.create(email: 'test@example.com', password: '123123') }
  let(:course) { Course.create(course_name: 'test course', description: 'course for testing') }

  before do
    # allow_any_instance_of(Shared::AuthorizationKit).to receive(:current_user).and_return(user)
  end

  describe 'GET /courses' do
    it 'returns all courses' do
      get '/api/courses'
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET /courses/search' do
  #   it 'returns courses that match the search term' do
  #     get '/api/courses/search', params: { term: course.course_name }
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body)['courses']).to include(course.as_json)
  #   end
  # end
  #
  describe 'POST /api/courses' do
    let(:auth_token) { '' }
    before do
      post '/api/auth/login', params: { email: user.email, password: '123123' }
      # auth_token = JSON.parse(response.body)['token']
      allow_any_instance_of(Shared::Helpers).to receive(:current_user).and_return(user)
      allow_any_instance_of(Shared::Helpers).to receive(:authenticate_user!).and_return(true)
    end
    it 'creates a new course' do
      post '/api/courses', params: { course_name: 'New Course', description: 'This is a new course' }
      expect(response).to have_http_status(:success)
      expect(Course.find_by(course_name: 'New Course')).to be_present
    end
  end
  #
  # describe 'GET /courses/:course_id' do
  #   it 'returns the specified course' do
  #     get "/api/courses/#{course.id}"
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body)).to eq(course.attributes.merge("sections" => []))
  #   end
  # end
  #
  # describe 'PUT /courses/:id' do
  #   it 'updates the specified course' do
  #     put "/api/courses/#{course.id}", params: { course_name: 'Updated Course' }
  #     expect(response).to have_http_status(:success)
  #     expect(course.reload.course_name).to eq('Updated Course')
  #   end
  # end
  #
  # describe 'POST /courses/:course_id/lessons' do
  #   it 'creates a new lesson for the specified course' do
  #     post "/api/courses/#{course.id}/lessons", params: { lesson: { title: 'New Lesson', content: 'This is a new lesson', price: 100 } }
  #     expect(response).to have_http_status(:success)
  #     expect(course.posts.find_by(title: 'New Lesson')).to be_present
  #   end
  # end
  #
  # describe 'GET /courses/:course_id/lessons/:lesson_id' do
  #   it 'returns the specified lesson' do
  #     get "/api/courses/#{course.id}/lessons/#{post.id}"
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body)).to eq(post.as_json)
  #   end
  # end
  #
  # describe 'PUT /courses/:course_id/lessons/:lesson_id' do
  #   it 'updates the specified lesson' do
  #     put "/api/courses/#{course.id}/lessons/#{post.id}", params: { title: 'Updated Lesson', content: 'This is an updated lesson' }
  #     expect(response).to have_http_status(:success)
  #     expect(post.reload.title).to eq('Updated Lesson')
  #   end
  # end
  #
  # describe 'GET /courses/:course_id/details' do
  #   it 'returns the details of the specified course' do
  #     get "/api/courses/#{course.id}/details"
  #     expect(response).to have_http_status(:success)
  #     expect(JSON.parse(response.body)['course']).to eq(course.attributes.merge("course_cover" => course.course_cover_url, "sections" => []))
  #   end
  # end
end