class Bookings < Grape::API
  namespace :bookings do
    desc 'get student bookings'
    get '/:student_id' do
      student = Student.find(params[:student_id])
      # authorize mentor, :update?
      bookings = student.bookings
      { bookings: bookings }
    end

  end
end