User.create(email: 'admin@example.com', password: 'password!', password_confirmation: 'password!', admin: true)
User.create(email: 'applicant@example.com', password: 'password!', password_confirmation: 'password!', admin: false)
User.create(email: 'applicant2@example.com', password: 'password!', password_confirmation: 'password!', admin: false)
