# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  user_id        :integer
#  article_id     :integer
#  revision_id    :integer
#  type           :string(255)
#  email_sent_at  :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  message        :text(65535)
#  target_user_id :integer
#  subject_id     :integer
#  resolved       :boolean          default(FALSE)
#  details        :text(65535)
#

require 'rails_helper'

describe BadWorkAlert do
  let(:course) { create(:course) }
  let(:student) { create(:user, email: 'student@example.edu') }
  let(:instructor) { create(:instructor, email: 'instructor@example.edu') }
  let(:expert) { create(:admin, email: 'admin-expert@example.edu', greeter: true) }
  let(:article) { create(:article) }

  before do
    create(:articles_course, course: course, article: article)
    courses_users = [
      { course_id: course.id, user_id: student.id, role: CoursesUsers::Roles::STUDENT_ROLE },
      { course_id: course.id, user_id: instructor.id, role: CoursesUsers::Roles::INSTRUCTOR_ROLE },
      { course_id: course.id, user_id: expert.id, role: CoursesUsers::Roles::WIKI_ED_STAFF_ROLE }
    ]
    CoursesUsers.create(courses_users)
  end

  let(:alert) do
    create(:bad_work_alert, user: instructor, course: course, article: article)
  end
end
