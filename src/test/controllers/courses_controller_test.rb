require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { course_id: @course.course_id, course_title: @course.course_title, description: @course.description, maximum_seats: @course.maximum_seats, minimum_seats: @course.minimum_seats, professor_id: @course.professor_id, seats_taken: @course.seats_taken } }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { course_id: @course.course_id, course_title: @course.course_title, description: @course.description, maximum_seats: @course.maximum_seats, minimum_seats: @course.minimum_seats, professor_id: @course.professor_id, seats_taken: @course.seats_taken } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
