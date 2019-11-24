require "application_system_test_case"

class EnrolledCoursesTest < ApplicationSystemTestCase
  setup do
    @enrolled_course = enrolled_courses(:one)
  end

  test "visiting the index" do
    visit enrolled_courses_url
    assert_selector "h1", text: "Enrolled Courses"
  end

  test "creating a Enrolled course" do
    visit enrolled_courses_url
    click_on "New Enrolled Course"

    fill_in "Course", with: @enrolled_course.course_id
    fill_in "Student", with: @enrolled_course.student_id
    click_on "Create Enrolled course"

    assert_text "Enrolled course was successfully created"
    click_on "Back"
  end

  test "updating a Enrolled course" do
    visit enrolled_courses_url
    click_on "Edit", match: :first

    fill_in "Course", with: @enrolled_course.course_id
    fill_in "Student", with: @enrolled_course.student_id
    click_on "Update Enrolled course"

    assert_text "Enrolled course was successfully updated"
    click_on "Back"
  end

  test "destroying a Enrolled course" do
    visit enrolled_courses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Enrolled course was successfully destroyed"
  end
end
