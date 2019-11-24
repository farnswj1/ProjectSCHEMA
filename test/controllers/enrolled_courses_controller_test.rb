require 'test_helper'

class EnrolledCoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enrolled_course = enrolled_courses(:one)
  end

  test "should get index" do
    get enrolled_courses_url
    assert_response :success
  end

  test "should get new" do
    get new_enrolled_course_url
    assert_response :success
  end

  test "should create enrolled_course" do
    assert_difference('EnrolledCourse.count') do
      post enrolled_courses_url, params: { enrolled_course: { course_id: @enrolled_course.course_id, student_id: @enrolled_course.student_id } }
    end

    assert_redirected_to enrolled_course_url(EnrolledCourse.last)
  end

  test "should show enrolled_course" do
    get enrolled_course_url(@enrolled_course)
    assert_response :success
  end

  test "should get edit" do
    get edit_enrolled_course_url(@enrolled_course)
    assert_response :success
  end

  test "should update enrolled_course" do
    patch enrolled_course_url(@enrolled_course), params: { enrolled_course: { course_id: @enrolled_course.course_id, student_id: @enrolled_course.student_id } }
    assert_redirected_to enrolled_course_url(@enrolled_course)
  end

  test "should destroy enrolled_course" do
    assert_difference('EnrolledCourse.count', -1) do
      delete enrolled_course_url(@enrolled_course)
    end

    assert_redirected_to enrolled_courses_url
  end
end
