admin = User.find_or_initialize_by(email: 'admin@example.com')
admin.update(password: 'password!', password_confirmation: 'password!', admin: true)

applicant1 = User.find_or_initialize_by(email: 'applicant1@example.com')
applicant1.update(password: 'password!', password_confirmation: 'password!', admin: false)

applicant2 = User.find_or_initialize_by(email: 'applicant2@example.com')
applicant2.update(password: 'password!', password_confirmation: 'password!', admin: false)

[applicant1, applicant2].each do |user|
  5.times do
    admin.recieved_applications << UserApplication.new(
      my_level: UserApplication.my_levels.keys.sample,
      fav_hobby: 'reading',
      scratch_before: [true, false].sample,
      user:
    )
  end
end
